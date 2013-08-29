#!/usr/bin/env ruby
require 'haml'
require 'html2haml'

Dir.glob(File.join('**', '*.erb')).each do |file|
   html = File.read(file)
   data = ''
   begin
       data = Haml::HTML.new(html, :erb => true, :xhtml => true).render
       new_file = file.gsub('erb', 'haml')
       if not File.exists?(new_file)
           f = File.new(new_file, 'w')
           f.write(data)
       end
   rescue
       next
   end
end