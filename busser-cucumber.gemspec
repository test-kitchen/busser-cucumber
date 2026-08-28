lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "busser/cucumber/version"

Gem::Specification.new do |spec|
  spec.name = "busser-cucumber"
  spec.required_ruby_version = ">= 3.2"
  spec.version       = Busser::Cucumber::VERSION
  spec.authors       = ["Jonathan Hartman"]
  spec.email         = %w{j@p4nt5.com}
  spec.description   = "A Busser plugin for Cucumber"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/test-kitchen/busser-cucumber"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.require_paths = %w{lib}

  spec.add_dependency "busser", ">= 0.9.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "aruba", ">= 2.0"
  spec.add_development_dependency "cucumber", ">= 11.1"
  spec.add_development_dependency "rspec", ">= 3.13"
end
