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
  TEMP=$(cat /sys/class/thermal/thermal_zone6/temp)
  echo $((TEMP / 1000))
}

mem() {
  echo "scale=2; $(free -m | sed -n 2p | awk '{print $3 + $5}') / 1000" | bc
}

cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "$cpu%"
}

SLEEP_SEC=3
PAD=" | "
while true; do
  echo "$(mem)G$PAD$(cpu)$PAD$(temp)°C$PAD$(bat)$PAD"
 sleep $SLEEP_SEC
done

