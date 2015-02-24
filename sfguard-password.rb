#!/usr/bin/env ruby
# Salt password for symfony1

require 'securerandom'
require 'digest/sha1'

`stty -echo`
print "Password: "
password = gets.chomp
`stty echo`
puts ""

salt = SecureRandom.hex(16)

hash = Digest::SHA1.hexdigest [salt, password].join('')

puts "The salt is #{salt}"
puts "The hash is #{hash}"