#!/bin/bash

# Give the current user the appropriate permissions
sudo chown -R $(whoami):$(whoami) scroll-sdk
sudo chmod -R u+rw scroll-sdk

indent_file_and_add_first_line () {
  echo $1
  temp_file="tmp_file"
  touch $temp_file

  echo "$2" > "$temp_file"
  # Indent each line of the original file by 2 spaces and append to the temporary file
  sed 's/^/  /' "$1" >> $temp_file
#  # Move the temporary file to replace the original file
  mv "$temp_file" "$1"

  echo "Processed file: $1"
}

# admin-systems
cp scroll-sdk/admin-system-backend-config.yaml scroll-sdk/admin-system-cron-config.yaml
indent_file_and_add_first_line "scroll-sdk/admin-system-backend-config.yaml" "admin-system-backend:"
indent_file_and_add_first_line "scroll-sdk/admin-system-cron-config.yaml" "admin-system-cron:"

# Balance-checker
indent_file_and_add_first_line "scroll-sdk/balance-checker-config.yaml" "balance-checker:"

# Bridge-history
cp scroll-sdk/bridge-history-config.yaml scroll-sdk/bridge-history-api-config.yaml
mv scroll-sdk/bridge-history-config.yaml scroll-sdk/bridge-history-fetcher-config.yaml
indent_file_and_add_first_line "scroll-sdk/bridge-history-api-config.yaml" "bridge-history-api:"
indent_file_and_add_first_line "scroll-sdk/bridge-history-fetcher-config.yaml" "bridge-history-fetcher:"

# chain-monitor
indent_file_and_add_first_line "scroll-sdk/chain-monitor-config.yaml" "chain-monitor:"

# coordinator
cp scroll-sdk/coordinator-config.yaml scroll-sdk/coordinator-api-config.yaml
mv scroll-sdk/coordinator-config.yaml scroll-sdk/coordinator-cron-config.yaml
indent_file_and_add_first_line "scroll-sdk/coordinator-api-config.yaml" "coordinator-api:"
indent_file_and_add_first_line "scroll-sdk/coordinator-cron-config.yaml" "coordinator-cron:"

# frontends
indent_file_and_add_first_line "scroll-sdk/frontend-config.yaml" "frontends:"

# contracts
cp scroll-sdk/config.toml scroll-sdk/scroll-common-config.yaml
cp scroll-sdk/config-contracts.toml scroll-sdk/scroll-common-config-contracts.yaml
{ echo "contracts:"; echo "  scrollConfig: |"; sed 's/^/    /' scroll-sdk/scroll-common-config.yaml; } > temp_file && mv temp_file scroll-sdk/scroll-common-config.yaml
{ echo "contracts:"; echo "  scrollConfigContracts: |"; sed 's/^/    /' scroll-sdk/scroll-common-config-contracts.yaml; } > temp_file && mv temp_file scroll-sdk/scroll-common-config-contracts.yaml

# scroll-common
indent_file_and_add_first_line "scroll-sdk/genesis.yaml" "scroll-common:"

# rollup
cp scroll-sdk/rollup-config.yaml scroll-sdk/gas-oracle-config.yaml
mv scroll-sdk/rollup-config.yaml scroll-sdk/rollup-node-config.yaml
indent_file_and_add_first_line "scroll-sdk/gas-oracle-config.yaml" "gas-oracle:"
indent_file_and_add_first_line "scroll-sdk/rollup-node-config.yaml" "rollup-node:"

# rollup-explorer-backend
indent_file_and_add_first_line "scroll-sdk/rollup-explorer-backend-config.yaml" "rollup-explorer-backend:"
