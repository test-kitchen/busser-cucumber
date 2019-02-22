# Encoding: UTF-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'busser/cucumber/version'

Gem::Specification.new do |spec|
  spec.name          = 'busser-cucumber'
  spec.version       = Busser::Cucumber::VERSION
  spec.authors       = ['Jonathan Hartman']
  spec.email         = %w(j@p4nt5.com)
  spec.description   = 'A Busser plugin for Cucumber'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/test-kitchen/busser-cucumber'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)\/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'busser'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'countloc'
  spec.add_development_dependency 'aruba', '0.6.1'
  spec.add_development_dependency 'cucumber', '1.3.18'
  spec.add_development_dependency 'rspec'
end
