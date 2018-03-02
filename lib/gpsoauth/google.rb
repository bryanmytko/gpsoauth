module Gpsoauth
  module Google
    class << self
      def key_from_b64(key)
        binary_key = Base64.decode64(key)

        i = binary_key[0, 4].sum
        mod = binary_key[4, i].unpack("H*")[0].to_i(16)

        j = binary_key[i + 4, 4].sum
        exponent = binary_key[i + 8, j].unpack("H*")[0].to_i(16)

        OpenSSL::PKey::RSA.new.tap do |k|
          k.e = OpenSSL::BN.new(exponent)
          k.n = OpenSSL::BN.new(mod)
        end
      end

      def signature(email, password, key)
        # Encryption scheme deconstructed here:
        # http://codedigging.com/blog/2014-06-09-about-encryptedpasswd/

        struct = key_to_struct(key).pack("c*")
        first_four_bytes_sha1 = OpenSSL::Digest::SHA1.digest(struct)[0...4]

        encrypted_login_password = key.public_encrypt(
          email + "\x00" + password,
          OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING,
        )

        signature = "\x00" + first_four_bytes_sha1 + encrypted_login_password
        Base64.urlsafe_encode64(signature)
      end

      private

      def long_to_bytes(key)
        arr = []
        key, mod = key.divmod(256)

        while mod > 0 || key > 0
          arr << mod
          key, mod = key.divmod(256)
        end

        arr.reverse
      end

      def key_to_struct(key)
        mod_buffer = "\x00\x00\x00\x80".unpack("C*")
        exponent_buffer = "\x00\x00\x00\x03".unpack("C*")

        mod = long_to_bytes(key.n.to_i)
        exponent = long_to_bytes(key.e.to_i)

        mod_buffer + mod + exponent_buffer + exponent
      end
    end
  end
end
