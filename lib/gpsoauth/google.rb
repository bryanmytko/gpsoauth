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
      struct = key_to_struct(key).pack("c*")
      signature.push Digest::SHA1.hexdigest(struct)[0,4]

      encrypted_login = key.public_encrypt(
        email + "\x00" + password + OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING
      )

      a = Base64.urlsafe_encode64(signature + encrypted_login)
      debugger

      # @TODO Encryptedpasswd notes:
      # http://codedigging.com/blog/2014-06-09-about-encryptedpasswd/
      #
      # cipher = PKCS1_OAEP.new(key)
      # encrypted_login = cipher.encrypt((email + u'\x00' + password).encode('utf-8'))
      # signature.extend(encrypted_login)
      # return base64.urlsafe_b64encode(signature)
    end

    private

    def self.key_to_struct(key)
      #@TODO
      mod = key.n.to_s.bytes
      exponent = key.e.to_s.bytes

      "\x00\x00\x00\x80#{mod}\x00\x00\x00\x03#{exponent}".b
    end
  end
end
