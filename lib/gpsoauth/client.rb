module Gpsoauth
  class Client
    AUTH_URL = "https://android.clients.google.com/auth"
    USER_AGENT = "gpsoauth/gpsoauth"

    # The key is distirbuted with Google Play Services.
    # This one is from version 7.3.29.
    B64_KEY_7_3_29 = "AAAAgMom/1a/v0lblO2Ubrt60J2gcuXSljGFQXgcyZWveWLEwo6p" \
    "rwgi3iJIZdodyhKZQrNWp5nKJ3srRXcUW+F1BD3baEVGcmEgqaLZUNBjm057pKRI16kB0" \
    "YppeGx5qIQ5QjKzsR8ETQbKLNWgRY0QRNVz34kMJR3P/LgHax/6rmf5AAAAAwEAAQ==".b

    def initialize(android_id, service = nil, device_country = nil,
                   operator_country = nil, lang = nil, sdk_version = nil)

      @android_id = android_id

      @service = service || "ac2dm"
      @device_country = device_country || "us"
      @operator_country = operator_country || "us"
      @lang = lang || "en"
      @sdk_version = sdk_version || 17
    end

    def use_proxy(host, port, login = nil, password = nil)
      @proxy_host = host
      @proxy_port = port
      @proxy_login = login
      @proxy_password = password

      return self
    end

    def master_login(email, password)
      android_key = Google::key_from_b64(B64_KEY_7_3_29)

      data = {
        accountType: "HOSTED_OR_GOOGLE",
        Email: email,
        has_permission: 1,
        add_account: 1,
        EncryptedPasswd: Google::signature(email, password, android_key),
        service: @service,
        source: "android",
        androidId: @android_id,
        device_country:  @device_country,
        operatorCountry: @operator_country,
        lang: @lang,
        sdk_version: @sdk_version
      }

      auth_request(data)
    end

    def oauth(email, master_token, service, app, client_signature)
      data = {
        accountType: "HOSTED_OR_GOOGLE",
        Email: email,
        has_permission: 1,
        Token: master_token,
        source: "android",
        androidId: @android_id,
        device_country:  @device_country,
        operatorCountry: @operator_country,
        lang: @lang,
        sdk_version: @sdk_version,
        service: service,
        app: app,
        client_sig: client_signature
      }

      auth_request(data)
    end

    private

    def auth_request(data)
      uri = URI(AUTH_URL)

      # Create client
      if @proxy_host && @proxy_port
        http = Net::HTTP.new(uri.host, uri.port, @proxy_host, @proxy_port, @proxy_login, @proxy_password)
      else
        http = Net::HTTP.new(uri.host, uri.port)
      end
      #http.set_debug_output $stdout
      http.use_ssl = true
      http.verify_mode = ::OpenSSL::SSL::VERIFY_NONE
      body = URI.encode_www_form(data)

      # Create Request
      req =  Net::HTTP::Post.new(uri)
      # Add headers
      req.add_field "User-Agent", USER_AGENT
      # Add headers
      req.add_field "Accept-Encoding", ""
      # Add headers
      #req.add_field "Content-Type", "application/json"
      # Set body
      req.body = body

      # Fetch Request
      res = http.request(req)

      parse_auth_response(res.body)
    end

    def parse_auth_response(response)
      Hash[response.each_line.map { |l| l.chomp.split("=", 2) }]
    end
  end
end
