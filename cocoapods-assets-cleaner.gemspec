# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-assets-cleaner/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-assets-cleaner'
  spec.version       = CocoapodsAssetsCleaner::VERSION
  spec.authors       = ['Leo Valentim']
  spec.email         = ['leo.valent@hotmail.com']
  spec.description   = %q{Assets-cleaner is a Cocoapods-plugin that helps to clean unused assets on Xcode projects.}
  spec.summary       = %q{Cocoapods-plugin that helps to clean unused assets on Xcode projects.}
  spec.homepage      = 'https://github.com/LeoValentim/cocoapods-assets-cleaner/'
  spec.license       = 'MIT'

  #spec.files = Dir['lib/**/*']
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency "cocoapods", ">= 1.5.0"

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
