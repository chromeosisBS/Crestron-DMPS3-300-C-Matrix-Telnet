#!/bin/bash
#
# This script connects to a specified IP address via telnet,
# sets a video route using provided slot IDs, and then closes the connection.
#
# Usage: ./set_video_route.sh <IP_ADDRESS> <SLOT_ID1> <SLOT_ID2>
#
# Example: ./set_video_route.sh 192.168.1.10 1 2
#

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <IP_ADDRESS> <SLOT_ID1> <SLOT_ID2>"
  echo "  <IP_ADDRESS>: The IP address of the device to telnet to."
  echo "  <SLOT_ID1>:  The first slot ID."
  echo "  <SLOT_ID2>:  The second slot ID."
  exit 1
fi

# Assign the command-line arguments to variables
IP_ADDRESS="$1"
SLOT_ID1="$2"
SLOT_ID2="$3"

# Log the parameters
echo "Connecting to IP: $IP_ADDRESS"
echo "Setting video route from slot: $SLOT_ID1 to slot: $SLOT_ID2"

# Use 'expect' to automate the telnet session.
expect -c "
  spawn telnet $IP_ADDRESS
  expect \"*>*\"  # Expect the telnet prompt (e.g., '> ', 'DMPS3-300-C>')
  send \"PASSTO SLOT 9\r\"
  expect \"*>*\"
  send \"PASSTO SLOT 9\r\"
  expect \"*>*\"
  send \"SETVIDEOROUTE $SLOT_ID1 $SLOT_ID2\r\"
  expect \"*>*\"
  send \"SETVIDEOROUTE $SLOT_ID1 $SLOT_ID2\r\"
  expect \"*>*\"
  expect eof
"

# If expect fails, the script will continue.  You might want to add error checking.
echo "Telnet session completed."
exit 0
