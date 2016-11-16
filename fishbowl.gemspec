# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fishbowl/version'

Gem::Specification.new do |gem|
  gem.name          = "fishbowl"
  gem.version       = Fishbowl::VERSION
  gem.authors       = ["James Thompson, Simeon Berns"]
  gem.email         = ["james@plainprograms.com, simeonberns@gmail.com"]
  gem.description   = %q{Provides an interface to the Fishbowl Inventory API}
  gem.summary       = %q{Fishbowl Inventory API}
  gem.homepage      = "https://github.com/flameofzion/fishbowl"
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'nokogiri', '~> 1.5', '>= 1.5.5'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.14.1'
  gem.add_development_dependency 'equivalent-xml'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'spork'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'pry'
end
