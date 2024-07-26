#!/bin/bash
# This script funds the default L1 accounts when using an Anvil devnet.

# Array of addresses
addresses=("0x70997970C51812dc3A010C7d01b50e0d17dc79C8" "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC" "0x90F79bf6EB2c4f870365E785982E1f101E93b906")  # Replace with your actual addresses

# Loop through each address and call the curl command
for address in "${addresses[@]}"
do
  curl --location 'http://l1-devnet.scrollsdk/' \
  --header 'Content-Type: application/json' \
  --data '{
    "jsonrpc":"2.0",
    "method":"anvil_setBalance",
    "params":["'"$address"'","0x3635C9ADC5DEA00000"],
    "id":0
  }'
done