$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_notifiable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "acts_as_notifiable"
  spec.version     = ActsAsNotifiable::VERSION
  spec.authors     = ["Valentin Druon"]
  spec.email       = ["valentin@dividom.com"]
  spec.homepage    = "http://github.com/dividom/acts_as_notifiable"
  spec.summary     = "Make any model be notifiable or act as a notifier."
  spec.description = "Make any model be notifiable or act as a notifier."
  spec.license     = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = ">= 2.2"

  spec.add_development_dependency "rails", "4.2.5"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rake", "~> 10"

  spec.add_dependency "activesupport", ">= 4.2"
  spec.add_dependency "activerecord", ">= 4.2"
end
