#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'terminal-notifier'
end

require 'terminal-notifier'

TerminalNotifier.notify 'I am a notification', title: 'Hello World'
