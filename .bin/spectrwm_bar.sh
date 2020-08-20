 bat() {
   charge=""
   battery="$(cat /sys/class/power_supply/BAT0/capacity)"
   if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
     charge="+"
   fi
   echo "$battery%$charge"
 }

 date() {
 	FORMAT="%R"
 	DATE=`date "+${FORMAT}"`
 	echo "${DATE}"
 }

temp() {
  TEMP=$(cat /sys/class/thermal/thermal_zone7/temp)
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
  cat /tmp/wttr
}

SLEEP_SEC=2
PAD=" | "
killall update.sh; $HOME/.bin/update.sh &
while true; do
 echo "$(mem)G$PAD$(cpu)$PAD$(wifi)$PAD$(temp)°C$PAD$(bat)$PAD$(wttr)$PAD"
 sleep $SLEEP_SEC
done

