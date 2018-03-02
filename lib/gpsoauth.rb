require "base64"
require "json"
require "net/http"
require "net/https"

require_relative "gpsoauth/client"
require_relative "gpsoauth/exceptions"
require_relative "gpsoauth/google"
require_relative "gpsoauth/keys"
require_relative "gpsoauth/version"

module Gpsoauth
  include Google
end
