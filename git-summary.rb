#!/usr/bin/env ruby

# usage: git-summary.rb [PATH] [NAME]
# Note: NAME must be in quotes if it contains spaces

path = ARGV.first || '.'
user_search = ARGV[1] unless ARGV[1].nil?
cwd = File.expand_path(path)
Dir.chdir(cwd)
Dir.glob(File.join('**', '.git')).each do |dir|
  dir_list = dir.split('/')[0..-2]
  Dir.chdir(dir_list.join('/'))
  status = `git status`
  log    = `git log`
  if status != "" && log != ""
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
