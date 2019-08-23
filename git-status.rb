#!/usr/bin/env ruby

# usage: git-status.rb [PATH]

path = ARGV.first || '.'
cwd = File.expand_path(path)
Dir.chdir(cwd)
Dir[File.join('**', '.git')]
  .select { |path| File.directory?(path) }
  .each do |dir|
    dir_list = dir.split('/')[0..-2]
    Dir.chdir(dir_list.join('/'))
    status   = `git status`
    remotes  = `git remote -v`
    stashes  = (`git stash list`).split("\n")
    statuses = {
      'Untracked' => "\e[31m\[Untracked\]\e[0m",
      'Changes not staged for commit' => "\e[31m\[Modified\]\e[0m",
      'Changes to be committed' => "\e[32m\[Staged\]\e[0m",
      'Your branch is ahead' => "\e[1;33m\[Unpushed\]\e[0m",
      'Your branch is behind' => "\e[36m\[Unmerged\]\e[0m",
    }
    found_statuses = []
    statuses.each do |key, value|
      found_statuses << value if status.include?(key)
    end
    if found_statuses.any? || remotes.length.zero? || stashes.length > 0
      puts File.expand_path('.')
    end
    if found_statuses.any?
      puts "  #{found_statuses.join(' ')}"
    end
    if remotes.length.zero?
      puts "  \e[1;33mNo remote found\e[0m"
    end
    unless stashes.length.zero?
      puts "  \e[36m #{stashes.length} stashes found\e[0m"
    end
    Dir.chdir(cwd)
  end
