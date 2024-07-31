#!/bin/bash
# Simple script to force transactions to be generated on the L1 network for producing more blocks.
# Sends a single tx every 5 seconds.

read_config() {
    yq eval "$1" charts/scroll-stack/config.toml
}

L1_RPC_URL=$(read_config '.frontend.EXTERNAL_RPC_URI_L1')
PRIVATE_KEY=$(read_config '.accounts.DEPLOYER_PRIVATE_KEY')
RECIPIENT_ADDR=$(read_config '.accounts.DEPLOYER_ADDR')

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
  cast send --rpc-url "$L1_RPC_URL" --private-key "$PRIVATE_KEY" "$RECIPIENT_ADDR" --value "0.1gwei"
  
  # Wait for 1 second
  sleep 5
done