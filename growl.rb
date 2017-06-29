#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'growl'
end

require 'growl'

notification = Growl.new
notification.message = 'Hello World'
#notification.sticky!
notification.icon = :pdf
#notification.icon = :jpeg
notification.run if Growl.installed?
