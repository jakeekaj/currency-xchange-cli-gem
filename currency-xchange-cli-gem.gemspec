# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'currency_xchange/version'

Gem::Specification.new do |spec|
  spec.name          = "currency-xchange-cli-gem"
  spec.version       = CurrencyXchange::VERSION
  spec.authors       = ["jakeekaj"]
  spec.email         = ["jakemalto@yahoo.com"]

  spec.summary       = %q{This gem provides a CLI interface to convert currencies from around the world}
  spec.description   = %q{This gem uses real-time data and conversion rates provided by x-rates.com }
  spec.homepage      = "https://github.com/jakeekaj/now-playing-cli-gem.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri"
  spec.add_dependency "nokogiri"
end
