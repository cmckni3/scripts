#!/usr/bin/env ruby

# usage: github-follow-status.rb <your username> <target username>

require 'net/http'
require 'uri'
require 'json'
require 'io/console'


class TerminalColor
  ANSI_CODES = {
    black:   30,
    red:     31,
    green:   32,
    yellow:  33,
    blue:    34,
    magenta: 35,
    cyan:    36,
    white:   37,
    gray:    90,
    bold:    1,
    underline: 4
  }

  def self.wrap(text, *styles)
    codes = styles.map { |style| ANSI_CODES[style] }.compact
    return text if codes.empty?

    "\e[#{codes.join(';')}m#{text}\e[0m"
  end
end

def check_relationship(auth_user, target_user, token)
  headers = {
    "Authorization" => "token #{token}",
    "User-Agent" => auth_user
  }

  base_url = "https://api.github.com"

  # Check if you follow them
  follows_uri = URI("#{base_url}/users/#{auth_user}/following/#{target_user}")
  follows_response = Net::HTTP.start(follows_uri.host, follows_uri.port, use_ssl: true) do |http|
    req = Net::HTTP::Get.new(follows_uri)
    headers.each { |k, v| req[k] = v }
    http.request(req)
  end

  # Check if they follow you
  followed_by_uri = URI("#{base_url}/users/#{target_user}/following/#{auth_user}")
  followed_by_response = Net::HTTP.start(followed_by_uri.host, followed_by_uri.port, use_ssl: true) do |http|
    req = Net::HTTP::Get.new(followed_by_uri)
    headers.each { |k, v| req[k] = v }
    http.request(req)
  end

  {
    you_follow_them: follows_response.code.to_i == 204,
    they_follow_you: followed_by_response.code.to_i == 204
  }
end

if ARGV.length != 2
  puts "Usage: github-follow-status.rb <your username> <target username>"
  exit
end

username, target = ARGV

print "🔐 Enter your GitHub token (input hidden): "
token = STDIN.noecho(&:gets).chomp
puts "\n"

result = check_relationship(username, target, token)

colored_you = TerminalColor.wrap(username, :cyan, :bold)
colored_target = TerminalColor.wrap(target, :blue, :bold)

if result[:you_follow_them] && result[:they_follow_you]
  puts "🎯 #{colored_you} and #{colored_target} follow each other!"
elsif result[:you_follow_them]
  puts "➡️  #{colored_you} follows #{colored_target}, but they don't follow #{colored_you}."
elsif result[:they_follow_you]
  puts "⬅️  #{colored_target} follows #{colored_you}, but you don't follow #{colored_target}."
else
  puts "❌ No follow relationship between #{colored_you} and #{colored_target}."
end
