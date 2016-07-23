module Gpsoauth
  module Google
    def self.key_from_b64(key)
      binary_key = Base64.decode64(key)

      # TODO Go to bed.
      i = binary_key[0,4].sum
      mod = binary_key[4, DISTANCE_NOT_RANGE].sum

      j = binary_key[i + 4, DISTANCE_NOT_RANGE].sum
      exponent = binary_key[i + 8, DISTANCE_NOT_RANGE].sum

      debugger
      v = OpenSSL::PKey::RSA.generate(mod, exponent)

    end

    def self.signature(email, password, key)
    end
  end
end
