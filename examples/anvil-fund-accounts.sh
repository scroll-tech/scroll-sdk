#!/bin/bash
# This script funds the default L1 accounts when using an Anvil devnet.

read_config() {
    yq eval "$1" charts/scroll-stack/config.toml
}

L1_RPC_URL=$(read_config '.frontend.EXTERNAL_RPC_URI_L1')

# Array of addresses
addresses=(
  "$(read_config '.accounts.L1_COMMIT_SENDER_ADDR')"
  "$(read_config '.accounts.L1_FINALIZE_SENDER_ADDR')"
  "$(read_config '.accounts.L1_GAS_ORACLE_SENDER_ADDR')"
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