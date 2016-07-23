module Gpsoauth
  class Connection
    # The key is distirbuted with Google Play Services.
    # This one is from version 7.3.29.
    B64_KEY_7_3_29 = "AAAAgMom/1a/v0lblO2Ubrt60J2gcuXSljGFQXgcyZWveWLEwo6prwgi3" \
    "iJIZdodyhKZQrNWp5nKJ3srRXcUW+F1BD3baEVGcmEgqaLZUNBjm057pKRI16kB0YppeGx5qIQ" \
    "5QjKzsR8ETQbKLNWgRY0QRNVz34kMJR3P/LgHax/6rmf5AAAAAwEAAQ==".b

    def master_login(email, password, android_id,
                     service = nil, device_country = nil,
                     operator_country = nil, lang = nil, sdk_version = nil)

      service = service || "acdm"
      device_country = device_country || "us"
      operator_country = operator_country || "us"
      lang = lang || "en"
      sdk_version = sdk_version || 17
    end

    def oauth
    end

    private

    def auth_request
    end
  end
end
