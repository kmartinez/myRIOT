# About
Adapted from the test code to either send repeated raw packets or receive them
Default is for samr30-xpro
sets 868MHz page0 and max power
for some reason setting page2 means receiver does not get packets

# Usage
set destination MAC address in main as it only sends to that
you can run ifconfig in the shell to start with to check settings
press user button for 1s on the sender
receiver term will show rssi:
2020-06-12 12:31:30,709 # txt: 16? RSSI: -26, LQI: 255 len: 2 8

the txt payload is an incrementing counter

