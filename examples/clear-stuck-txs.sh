#!/bin/bash
# Simple script to replace txs stuck in mempool. Can happen when CCC gets overloaded.
# Sends a single tx every 1 seconds with high gas fee.
# May need to set a manual nonce.

read_config() {
    yq eval "$1" charts/scroll-sdk/config.toml
}

L2_RPC_URL=$(read_config '.frontend.EXTERNAL_RPC_URI_L2')
PRIVATE_KEY=$(read_config '.accounts.DEPLOYER_PRIVATE_KEY')
RECIPIENT_ADDR=$(read_config '.accounts.DEPLOYER_ADDR')

# Number of iterations
iterations=1

# Loop for the specified number of iterations
for ((i=1; i<=iterations; i++))
do
  # Call the "cast send" command
  cast send --rpc-url "$L2_RPC_URL" --private-key "$PRIVATE_KEY" "$RECIPIENT_ADDR" --value "0.1gwei" --legacy --gas-price "10gwei"

  # Wait for 5 seconds
  sleep 5
done

echo "Completed $iterations iterations."
