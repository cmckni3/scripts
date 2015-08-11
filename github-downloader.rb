#!/usr/bin/env ruby

github_username_or_organization = ARGV[0]

unless github_username_or_organization
  puts 'Error: No GitHub username or organization provided'
  Process.exit(1)
end

directory = ARGV[1] || 'code'
directory = File.expand_path(directory)

require 'rubygems'
require 'octokit' # gem install octokit

1.upto(10) do |page|
  Octokit.repositories(github_username_or_organization, page: page, per_page: 100).each do |repo|
    system "git clone https://github.com/#{github_username_or_organization}/#{repo.name} #{directory}/#{repo.name}"
  end
end
