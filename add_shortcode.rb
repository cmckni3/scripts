def myFunction(args = {})
  puts args.inspect
  puts args[:test] if args[:test]
end

def add_shortcode(str)
  str = '[myFunction test="test1" test2="test3"]'
  short = str.gsub(/[[:space:]]/, ' ').split
  func_name = short.shift.gsub('"', '').gsub('"', '').gsub('\"', '').gsub('[', '').gsub(']', '').strip
  args = {}
  short.each do |item|
    h = item.split("=")
    key = h.first.gsub('"', '').gsub('"', '').gsub('\"', '').gsub('[', '').gsub(']', '').strip.to_sym
    value = h.last.gsub('"', '').gsub('"', '').gsub('\"', '').gsub('[', '').gsub(']', '').strip
    args[h.first.strip.to_sym] = value
  end
  send(func_name, args)
end
