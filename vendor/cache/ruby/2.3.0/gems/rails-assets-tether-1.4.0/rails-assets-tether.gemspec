# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-tether/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-tether"
  spec.version       = RailsAssetsTether::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "A client-side library to make absolutely positioned elements attach to elements in the page efficiently."
  spec.summary       = "A client-side library to make absolutely positioned elements attach to elements in the page efficiently."
  spec.homepage      = "http://github.hubspot.com/tether"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
