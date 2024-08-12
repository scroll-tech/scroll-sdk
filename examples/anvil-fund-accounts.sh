#!/bin/bash
# This script funds the default L1 accounts when using an Anvil devnet.

read_config() {
    yq eval "$1" charts/scroll-sdk/config.toml
}

L1_RPC_URL="l1-2.devnet.scroll.tech"

# Array of addresses
addresses=(
  "$(read_config '.accounts.L1_COMMIT_SENDER_ADDR')"
  "$(read_config '.accounts.L1_FINALIZE_SENDER_ADDR')"
  "$(read_config '.accounts.L1_GAS_ORACLE_SENDER_ADDR')"
  "0x98110937b5D6C5FCB0BA99480e585D2364e9809C"
)

# Loop through each address and call the curl command
for address in "${addresses[@]}"
do
  curl --location "$L1_RPC_URL" \
  --header 'Content-Type: application/json' \
  --data '{
    "jsonrpc":"2.0",
    "method":"anvil_setBalance",
    "params":["'"$address"'","0x3635C9ADC5DEA00000"],
    "id":0
  }'
done
