#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rmagick'
end

require 'RMagick'
image = Magick::ImageList.new('image.jpg').first
thumb = image.resize_to_fit(300, 300)
thumb.write File.expand_path(['~/Downloads/thumbnail_test', 'png'].join('.'))


image = Magick::ImageList.new('file.pdf').first
thumb = image.resize_to_fit(300, 300)
thumb.write(File.expand_path(['~/Downloads/thumbnail_test2', 'png'].join('.')))
