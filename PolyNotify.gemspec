# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'PolyNotify/version'

Gem::Specification.new do |spec|
  spec.name          = "PolyNotify"
  spec.version       = PolyNotify::VERSION
  spec.authors       = ["Chris911"]
  spec.email         = ["Christophe.naud.dulude@gmail.com"]
  spec.description   = "Notifier for Polytechnique Montreal student portal"
  spec.summary       = "Notifier for Polytechnique Montreal student portal"
  spec.homepage      = "https://github.com/Chris911/PolyNotify"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "nokogiri"
end
