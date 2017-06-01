# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gpsoauth/version'

Gem::Specification.new do |spec|
  spec.name          = "gpsoauth"
  spec.version       = Gpsoauth::VERSION
  spec.authors       = ["Bryan Mytko"]
  spec.email         = ["bryanmytko@gmail.com"]

  spec.summary       = %q{A Ruby client library for Google Play Services OAuth.}
  spec.description   = %q{A Ruby client library for Google Play Services OAuth.
                          A port of the Python library gpsoauth by Simon Weber}
  spec.homepage      = "http://github.com/bryanmytko/gpsoauth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.9.0"
  spec.add_development_dependency "byebug", "~> 9.0.5"
end
