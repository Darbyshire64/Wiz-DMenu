#!/bin/bash

IP="10.252.0.214"   # Your Wiz bulb IP
PORT=38899          # Wiz default port (UDP)

send_udp_command() {
  local cmd=$1
  echo -n "$cmd" | nc -u -w1 "$IP" "$PORT"
}

main_menu() {
  echo -e "Turn On\nTurn Off\nCool White\nNeutral White\nWarm White\nBrightness" | \
    rofi -dmenu -p "Wiz Light Control"
}

brightness_menu() {
  echo -e "100%\n75%\n50%\n25%" | rofi -dmenu -p "Set Brightness"
}

handle_brightness() {
  case "$1" in
    "100%")
      send_udp_command '{"method":"setPilot","params":{"dimming":100}}'
      ;;
    "75%")
      send_udp_command '{"method":"setPilot","params":{"dimming":75}}'
      ;;
    "50%")
      send_udp_command '{"method":"setPilot","params":{"dimming":50}}'
      ;;
    "25%")
      send_udp_command '{"method":"setPilot","params":{"dimming":25}}'
      ;;
  esac
}

# --- Main logic ---
CHOICE=$(main_menu)

case "$CHOICE" in
  "Turn On")
    send_udp_command '{"method":"setPilot","params":{"state":true}}'
    ;;
  "Turn Off")
    send_udp_command '{"method":"setPilot","params":{"state":false}}'
    ;;
  "Cool White")
    send_udp_command '{"method":"setPilot","params":{"temp":153}}'
    ;;
  "Neutral White")
    send_udp_command '{"method":"setPilot","params":{"temp":320}}'
    ;;
  "Warm White")
    send_udp_command '{"method":"setPilot","params":{"temp":454}}'
    ;;
  "Brightness")
    BRI_CHOICE=$(brightness_menu)
    handle_brightness "$BRI_CHOICE"
    ;;
  *)
    # Cancelled
    ;;
esac

