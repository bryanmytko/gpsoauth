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
      signature = "\x00".bytes
      struct = key_to_struct(key)
      signature.push Digest::SHA1.hexdigest(struct)[0,4]

      # cipher = PKCS1_OAEP.new(key)
      # encrypted_login = cipher.encrypt((email + u'\x00' + password).encode('utf-8'))
      # signature.extend(encrypted_login)
      # return base64.urlsafe_b64encode(signature)
    end

    private

    def self.key_to_struct(key)
      # @TODO double check format
      mod = key.n.to_s.bytes.map{ |x| x.to_s(16) }.join
      exponent = key.e.to_s.bytes.map{ |x| x.to_s(16) }.join

      "\x00\x00\x00\x80#{mod}\x00\x00\x00\x03#{exponent}".b
    end
  end
end
