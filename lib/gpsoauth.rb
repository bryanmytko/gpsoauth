# require "gpsoauth/version"

module Gpsoauth
  def master_login(email, password, android_id, service, device_country,
                   operator_country, lang, sdk_version)

    service ||= "acdm"
    device_country ||= "us"
    operator_country ||= "us"
    lang ||= "en"
    sdk_version ||= 17
  end

  def oauth
  end

  private

  def auth_request
  end
end
