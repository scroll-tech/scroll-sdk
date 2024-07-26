#!/bin/bash
# Simple script to force transactions to be generated on the L2 network for producing more blocks.
# Sends a single tx every 5 seconds.

# Function to handle script termination
cleanup() {
  echo "Script terminated."
  exit 0
}

# Trap SIGINT (Ctrl+C) to cleanly terminate the script
trap cleanup SIGINT

# Infinite loop
while true
do
  # Call the "cast send" command
  cast send --rpc-url http://l2-rpc.scrollsdk  --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" --value "0.1gwei"
  
  # Wait for 5 seconds
  sleep 5
done