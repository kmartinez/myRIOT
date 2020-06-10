# About
Adapted from the test code to either send repeated packets or receive them
Default is for samr30-xpro

This is a manual test application for the AT86RF2xx radio driver

For running this test, you need to connect/configure the following pins of your
radio device:
- SPI MISO
- SPI MOSI
- SPI CLK
- CS (ship select)
- RESET
- SLEEP
- INT (external interrupt)

# Usage
For testing the radio driver you can use the netif and txtsnd shell commands
that are included in this application.
uncommend the sender in main to make it the sender ;-)
