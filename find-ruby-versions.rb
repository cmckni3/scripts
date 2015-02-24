#!/usr/bin/env ruby

# usage: find-ruby-versions.rb [PATH] [RUBY_VERSION]
# Note: NAME must be in quotes if it contains spaces

path = ARGV.first || '.'
user_search = ARGV[1] unless ARGV[1].nil?
cwd = File.expand_path(path)
Dir.chdir(cwd)
Dir.glob(File.join('**', '.ruby-version')).each do |file|
  version = File.open(file, 'r').readline
  if user_search && version =~ Regexp.new(Regexp.escape(user_search))
    puts "Found #{file} like #{user_search}. Exact version is #{version}"
  else
    puts "Found .ruby-version file: #{file} with version #{version}"
  end
end
