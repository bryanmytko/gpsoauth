module Gpsoauth
  class Connection
    # The key is distirbuted with Google Play Services.
    # This one is from version 7.3.29.

    B64_KEY_7_3_29 = "AAAAgMom/1a/v0lblO2Ubrt60J2gcuXSljGFQXgcyZWveWLEwo6p" \
    "rwgi3iJIZdodyhKZQrNWp5nKJ3srRXcUW+F1BD3baEVGcmEgqaLZUNBjm057pKRI16kB0" \
    "YppeGx5qIQ5QjKzsR8ETQbKLNWgRY0QRNVz34kMJR3P/LgHax/6rmf5AAAAAwEAAQ==".b

    def master_login(email, password, android_id,
                     service = nil, device_country = nil,
                     operator_country = nil, lang = nil, sdk_version = nil)

      service = service || "acdm"
      device_country = device_country || "us"
      operator_country = operator_country || "us"
      lang = lang || "en"
      sdk_version = sdk_version || 17

      android_key = Google::key_from_b64(B64_KEY_7_3_29)

      data = {
        accountType: "HOSTED_OR_GOOGLE",
        Email:   email,
        has_permission:  1,
        add_account: 1,
        EncryptedPasswd: Google::signature(email, password, android_key),
        service: service,
        source: "android",
        androidId: android_id,
        device_country:  device_country,
        operatorCountry: device_country,
        lang: lang,
        sdk_version: sdk_version
      }

      p B64_KEY_7_3_29

      auth_request(data)
    end

    def oauth
    end

    private

    def auth_request(data)
      # res = requests.post(auth_url, data, headers={'User-Agent': useragent})

      # @TODO Google::Parse_auth_response(res.text)
    end

    def android_key(b64_key)
    end
  end
end
