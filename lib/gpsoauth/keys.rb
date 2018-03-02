module Gpsoauth
  class Keys
    # Keys are distributed with Google Play Services

    # Version 7.3.29
    V_7_3_29 = "AAAAgMom/1a/v0lblO2Ubrt60J2gcuXSljGFQXgcyZWveWLEwo6p" \
    "rwgi3iJIZdodyhKZQrNWp5nKJ3srRXcUW+F1BD3baEVGcmEgqaLZUNBjm057pKRI16kB0" \
    "YppeGx5qIQ5QjKzsR8ETQbKLNWgRY0QRNVz34kMJR3P/LgHax/6rmf5AAAAAwEAAQ==".freeze

    class << self
      def default
        V_7_3_29.b
      end
    end
  end
end
