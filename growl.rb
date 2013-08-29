#!/usr/bin/env ruby

require 'growl'
notification = Growl.new
notification.message = 'Hello World'
#notification.sticky!
notification.icon = :pdf
#notification.icon = :jpeg
notification.run if Growl.installed?
