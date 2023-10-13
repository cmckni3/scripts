#!/usr/bin/env ruby

require 'uri'

# usage: git-update-github-remote.rb [PATH]

path = ARGV.first || '.'
cwd = File.expand_path(path)
Dir.chdir(cwd)
Dir[File.join('**', '.git')]
  .select { |path| File.directory?(path) }
  .each do |dir|
    dir_list = dir.split('/')[0..-2]
    Dir.chdir(dir_list.join('/'))
    remotes  = `git remote`.split("\n")

    remotes.each do |remote|
      remote_url = `git remote get-url --all #{remote}`.strip
      if remote_url.start_with?('git://github.com')
        puts "need to change url for remote #{remote}: #{remote_url}"

        remote_uri = URI.parse(remote_url)
        owner, repository = remote_uri.path.split('/').drop(1)
        puts "owner #{owner}"
        puts "repository #{repository}"

        new_remote_url = "git@github.com:#{owner}/#{repository}"
        puts "new remote should be #{new_remote_url}"

        update_remote_command = "git remote set-url '#{remote}' '#{new_remote_url}'"
        puts "command to change remote #{update_remote_command}\n\n"
        remote_updated = `#{update_remote_command}`
      end
    end

    Dir.chdir(cwd)
  end
