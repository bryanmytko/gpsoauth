require "minitest/autorun"
require "./lib/gpsoauth"
require "./lib/gpsoauth/google"

class TestGoogle < Minitest::Test
  def setup
    @android_id = "9774d56d682e549c"
    @key = Gpsoauth::Google::key_from_b64(Gpsoauth::Client::B64_KEY_7_3_29)
  end

  def test_token_is_valid
    sig = Gpsoauth::Google.signature('test@test.com', 'password123', @key)
    assert_kind_of String, sig
  end
end
