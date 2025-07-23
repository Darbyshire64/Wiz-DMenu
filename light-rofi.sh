#!/bin/bash

IP="10.252.0.214"   # Your bulb's IP
PORT=38899          # UDP port for Wiz bulbs

send_udp_command() {
  local cmd=$1
  echo -n "$cmd" | nc -u -w1 "$IP" "$PORT"
}

OPTIONS="Turn On\nTurn Off\nCool White\nNeutral White\nWarm White"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Wiz Light Control")

case "$CHOICE" in
  "Turn On")
    send_udp_command '{"method":"setPilot","params":{"state":true}}'
    ;;
  "Turn Off")
    send_udp_command '{"method":"setPilot","params":{"state":false}}'
    ;;
  "Cool White")
    send_udp_command '{"method":"setPilot","params":{"temp":2700}}'
    ;;
  "Neutral White")
    send_udp_command '{"method":"setPilot","params":{"temp":4000}}'
    ;;
  "Warm White")
    send_udp_command '{"method":"setPilot","params":{"temp":6000}}'
    ;;
  *)
    # User cancelled or closed menu, do nothing
    ;;
esac

