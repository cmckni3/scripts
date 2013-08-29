#!/usr/bin/env ruby

path = ARGV.first || '.'
user_search = ARGV[1] unless ARGV[1].nil?
cwd = File.expand_path(path)
Dir.chdir(cwd)
Dir.glob(File.join('**', '*.zip')).each do |file|
  name = file[0..-5]
  puts name
  #Dir.mkdir(name)
  `unzip "#{file}" -d "#{name}"`
end
