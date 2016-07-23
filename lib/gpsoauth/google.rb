module Gpsoauth
  module Google
    def self.key_from_b64(key)
      binary_key = Base64.decode64(key)

      i = binary_key[0,4].sum
      mod = binary_key[4, i].unpack("H*")[0].to_i(16)


      j = binary_key[i + 4, 4].sum
      exponent = binary_key[i + 8, j].unpack("H*")[0].to_i(16)

      key = OpenSSL::PKey::RSA.new
      key.e = OpenSSL::BN.new(exponent)
      key.n = OpenSSL::BN.new(mod)

      key
    end

    def self.signature(email, password, key)
    end
  end
end
