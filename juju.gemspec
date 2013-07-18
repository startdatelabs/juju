# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juju/version'

Gem::Specification.new do |spec|
  spec.name          = "juju"
  spec.version       = Juju::VERSION
  spec.authors       = ["Elena Burachevskaya"]
  spec.email         = ["elena.burachevskaya@startdatelabs.com"]
  spec.description   = %q{Juju search engine API wrapper}
  spec.summary       = %q{Get the jobs feed using Juju API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "rest-client"
end
