#!/bin/bash
# Simple script to replace txs stuck in mempool. Can happen when CCC gets overloaded.
# Sends a single tx every 1 seconds with high gas fee.

# Number of iterations
iterations=1

# Loop for the specified number of iterations
for ((i=1; i<=iterations; i++))
do
  # Call the "cast send" command
  cast send --rpc-url http://l2-rpc.scrollsdk  --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" --value "0.1gwei" --legacy --gas-price "10gwei"
  
  # Wait for 5 seconds
  sleep 5
done

echo "Completed $iterations iterations."