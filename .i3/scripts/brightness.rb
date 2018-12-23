#!/home/talin/.rvm/rubies/ruby-2.2.1/bin/ruby

if ARGV[0] == '--inc'
  `xbacklight -inc 10 -time 0 -steps 1`
elsif ARGV[0] == '--dec'
  `xbacklight -dec 10 -time 0 -steps 1`
end

brightness = `xbacklight`.to_f.round

`/home/talin/.i3/scripts/notify-send.sh --hint=string:synchronous:brightness --hint=int:value:#{brightness} --icon=/usr/share/icons/HighContrast/32x32/status/display-brightness.png --replace-file=/tmp/brightness-notification "brightness: #{brightness}"`
