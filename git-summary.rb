#!/usr/bin/env ruby

# usage: git-summary.rb [PATH] [NAME]

path = ARGV.first || '.'
cwd = File.expand_path(path)
user_search = ARGV[1] unless ARGV[1].nil?
Dir.chdir(cwd)
Dir.glob(File.join('**', '.git')).each do |dir|
  dir_list = dir.split('/')[0..-2]
  Dir.chdir(dir_list.join('/'))
  status = `git status`
  log    = `git log 2>&1`
  if $?.success?
    summary = `git summary`
    if user_search
      log_emails = `git log --pretty="%ce"`
      puts File.expand_path('.') if summary.match(user_search) || log_emails.match(user_search)
    else
      puts summary
    end
  else
    puts "#{File.expand_path('.')} does not have any commits!"
  end
  Dir.chdir(cwd)
end
