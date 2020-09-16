 bat() {
   charge=""
   battery="$(cat /sys/class/power_supply/BAT0/capacity)"
   if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
     charge="+"
   fi
   echo "$battery%$charge"
 }

 time_date() {
 	FORMAT="%a %m.%d.%y %T"
 	DATE=`date "+${FORMAT}"`
 	echo "${DATE}"
 }

temp() {
  TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
  echo $((TEMP / 1000))
}

mem() {
  echo "scale=2; $(free -m | sed -n 2p | awk '{print $3 + $5}') / 1000" | bc
}

cpu() {
  read prevtotal previdle < /tmp/cpu
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "$cpu%"
  echo $total $idle > /tmp/cpu
}

ip() {
  echo "$(curl ifconfig.io)"
}

wifi() {
  cat /tmp/wifi
}

wttr() {
  cat /tmp/wttr | head -c 7
}

SLEEP_SEC=1
PAD=" | "
killall update.sh; $HOME/.bin/update.sh &
while true; do
  xsetroot -name "  $(mem)G$PAD$(cpu)$PAD$(temp)°C$PAD$(wttr)$PAD$(time_date)  "
  sleep $SLEEP_SEC
done

