#!/usr/bin/ruby

[0, 1, 4, 5, 7].each do |attr|
  puts '----------------------------------------------------------------'
  puts "ESC[#{attr};Foreground;Background"
  30.upto(37) do |fg|
    40.upto(47) do |bg|
      print "\033[#{attr};#{fg};#{bg}m #{fg};#{bg}  "
    end
  puts "\033[0m"
  end
end
