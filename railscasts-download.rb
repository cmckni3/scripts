#!/usr/bin/env ruby

directory = ARGV.first || 'code'
directory = File.expand_path(directory)

require 'rubygems'
require 'octokit' # gem install octokit

1.upto(10) do |page|
    Octokit.repositories("railscasts", page: page, per_page: 100).each do |repo|
        system "git clone git://github.com/railscasts/#{repo.name} #{directory}/#{repo.name}"
    end
end
