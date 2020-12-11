# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_assertions/version'

Gem::Specification.new do |spec|
  spec.name          = "mail_assertions"
  spec.version       = MailAssertions::VERSION
  spec.authors       = ["Magnus Hult"]
  spec.email         = ["magnus@magnushult.se"]

  spec.summary       = %q{Minitest asserts for checking that specific emails were (or were not) sent.}
  spec.homepage      = "https://github.com/hult/mail_assertions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "activesupport", "~> 5.0"
  spec.add_development_dependency "actionmailer", "~> 5.0"
end
