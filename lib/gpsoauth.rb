require "httparty"
require "byebug"
require "base64"

require "gpsoauth/connection"
require "gpsoauth/exceptions"
require "gpsoauth/google"
require "gpsoauth/utility"
require "gpsoauth/version"

module Gpsoauth
  include HTTParty
  include Google
end
