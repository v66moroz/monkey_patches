# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monkey_patches/version'

Gem::Specification.new do |spec|
  spec.name          = "monkey_patches"
  spec.version       = MonkeyPatches::VERSION
  spec.authors       = ["Victor Moroz"]
  spec.email         = ["v66moroz@gmail.com"]
  spec.summary       = %q{Monkey patches}
  spec.description   = %q{Monkey patches}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
