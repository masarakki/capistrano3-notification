# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano3/notification/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano3-notification'
  spec.version       = Capistrano3::Notification::VERSION
  spec.authors       = ['masarakki']
  spec.email         = ['masaki@hisme.net']
  spec.summary       = 'notification for capistrano-3.x'
  spec.description   = 'notification for capistrano-3.x'
  spec.homepage      = 'https://github.com/masarakki/capistrano3-notification'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano'
  spec.add_dependency 'shout-bot'
  spec.add_dependency 'slack-notifier'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
end
