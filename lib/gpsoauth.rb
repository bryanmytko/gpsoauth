require "httparty"
require "base64"

require "gpsoauth/client"
require "gpsoauth/exceptions"
require "gpsoauth/google"
require "gpsoauth/version"

module Gpsoauth
  include HTTParty
  include Google
end
