module Gpsoauth
  class Client
    ACCOUNT_TYPE = "HOSTED_OR_GOOGLE".freeze
    ADD_ACCOUNT = 1
    AUTH_URL = "https://android.clients.google.com/auth".freeze
    PERMISSION = 1
    SOURCE = "android".freeze
    USER_AGENT = "gpsoauth/gpsoauth".freeze

    DEFAULT_DEVICE_COUNTRY = "us".freeze
    DEFAULT_LANG = "en".freeze
    DEFAULT_OPERATOR_COUNTRY = "us".freeze
    DEFAULT_SDK_VERSION = 17
    DEFAULT_SERVICE = "ac2dm".freeze

    attr_reader :android_id, :device_country, :lang, :operator_country,
      :sdk_version, :service

    attr_reader :proxy_host, :proxy_login, :proxy_password, :proxy_port

    def initialize(android_id, device_country: nil, lang: nil,
                   operator_country: nil, sdk_version: nil, service: nil)

      @android_id = android_id
      @device_country = device_country || DEFAULT_DEVICE_COUNTRY
      @lang = lang || DEFAULT_LANG
      @operator_country = operator_country || DEFAULT_OPERATOR_COUNTRY
      @sdk_version = sdk_version || DEFAULT_SDK_VERSION
      @service = service || DEFAULT_SERVICE
    end

    def use_proxy(host, port, login: nil, password: nil)
      @proxy_host = host
      @proxy_login = login
      @proxy_password = password
      @proxy_port = port
    end

    def master_login(email, password)
      android_key = Google::key_from_b64(Keys.default)
      password = Google::signature(email, password, android_key)

      data = {
        accountType: ACCOUNT_TYPE,
        Email: email,
        has_permission: PERMISSION,
        add_account: ADD_ACCOUNT,
        EncryptedPasswd: password,
        service: service,
        source: SOURCE,
        androidId: android_id,
        device_country:  device_country,
        operatorCountry: operator_country,
        lang: lang,
        sdk_version: sdk_version,
      }

      auth_request(data)
    end

    def oauth(email, master_token, service, app, client_signature)
      data = {
        accountType: ACCOUNT_TYPE,
        Email: email,
        has_permission: PERMISSION,
        Token: master_token,
        source: SOURCE,
        androidId: android_id,
        device_country:  device_country,
        operatorCountry: operator_country,
        lang: lang,
        sdk_version: sdk_version,
        service: service,
        app: app,
        client_sig: client_signature,
      }

      auth_request(data)
    end

    private

    def auth_request(data)
      uri = URI(AUTH_URL)
      req_args = [uri.host, uri.port]
      args = using_proxy? ? req_args + proxy_args : req_args

      http = Net::HTTP.new(*args).tap do |h|
        h.use_ssl = true
        h.verify_mode = ::OpenSSL::SSL::VERIFY_NONE
      end

      request = Net::HTTP::Post.new(uri).tap do |r|
        r.add_field "User-Agent", USER_AGENT
        r.add_field "Accept-Encoding", ""
        r.body = URI.encode_www_form(data)
      end

      response = http.request(request)

      parse_auth_response(response.body)
    end

    def proxy_args
      %w(proxy_host proxy_port proxy_login proxy_password)
    end

    def using_proxy?
      proxy_host && proxy_port
    end

    def parse_auth_response(response)
      Hash[response.each_line.map { |l| l.chomp.split("=", 2) }]
    end
  end
end
