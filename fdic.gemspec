# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fdic/version'

Gem::Specification.new do |spec|
  spec.name          = "fdic"
  spec.version       = FDIC::VERSION
  spec.authors       = ["Tom Reznick", "Dan Bernier"]
  spec.email         = ["treznick@continuity.net", "dbernier@continuity.net"]

  spec.summary       = %q{A Ruby client to the FDIC's BankFind API}
  spec.description   = %q{The FDIC recently exposed a JSON-over-HTTP API behind its BankFind website. This gem makes that API easy to use from Ruby.}
  spec.homepage      = "https://github.com/ContinuityControl/fdic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.13"
  spec.add_runtime_dependency "json-schema", "~> 2.8"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 8.0"
end
