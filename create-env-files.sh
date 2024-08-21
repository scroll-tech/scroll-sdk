#!/bin/bash
# This script creates a dedicated env file for each service needing it from the config.toml file
# We hence centralize the configuration of the services on the config.toml file.

CONFIG_TOML="charts/scroll-stack/config.toml"
CONTRACT_CONFIG_TOML="charts/scroll-stack/config-contracts.toml"

# Function to check if a file exists and delete it if it does
delete_file_if_exists() {
    # Check if the parameter is provided
    if [ -z "$1" ]; then
        echo "No file specified."
        return 1
    fi

    # Check if the file exists
    if [ -f "$1" ]; then
        # File exists, delete it
        rm "$1"
        echo "File '$1' exists, deleting it ..."
    fi
}

# Function to get variables for a given service
get_service_variables() {
    local service_name=$1
    case "$service_name" in
        balance-checker)
            echo "CHAIN_ID_L1:SCROLL_L1_RPC CHAIN_ID_L2:SCROLL_L2_RPC"
            ;;
        blockscout)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC BLOCKSCOUT_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        bridge-history-api)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC  L2_RPC_ENDPOINT:SCROLL_L2_RPC"
            ;;
        bridge-history-fetcher)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC L2_RPC_ENDPOINT:SCROLL_L2_RPC BRIDGE_HISTORY_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        chain-monitor)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC CHAIN_MONITOR_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        contracts)
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT CHAIN_ID_L1:CHAIN_ID_L1 CHAIN_ID_L2:CHAIN_ID_L2"
            ;;
        coordinator)
            echo "DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT COORDINATOR_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        gas-oracle)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC GAS_ORACLE_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        l1-devnet)
            echo "CHAIN_ID_L1:CHAIN_ID"
            ;;
        l1-explorer)
            echo "CHAIN_ID_L1:CHAIN_ID L1_EXPLORER_DB_CONNECTION_STRING:DATABASE_URL L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_HTTP_URL L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_TRACE_URL L1_RPC_ENDPOINT:JSON_RPC L1_RPC_ENDPOINT_WEBSOCKET:ETHEREUM_JSONRPC_WS_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        l2-bootnode)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT"
            ;;
        l2-rpc)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT L1_CONTRACT_DEPLOYMENT_BLOCK:L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK"
            ;;
        l2-sequencer)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT L2GETH_SIGNER_0_ADDRESS:L2GETH_SIGNER_ADDRESS L1_CONTRACT_DEPLOYMENT_BLOCK:L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK"
            ;;
        rollup-node)
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT ROLLUP_NODE_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT L1_SCROLL_CHAIN_PROXY_ADDR:L1_SCROLL_CHAIN_PROXY_ADDR"
            ;;
        admin-system-backend)
            echo "ADMIN_SYSTEM_BACKEND_DB_CONNECTION_STRING:DATABASE_URL DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        *)
            echo "Service $service_name not found."
            ;;
    esac
}

extract_from_config_toml() {
  # Check if the correct number of arguments is given
  if [ "$#" -lt 2 ]; then
    echo "Usage: $0 tome_file source_target_pairs"
    echo "Example: $0 tome_file.txt var1:target1 var2:target2 ..."
    exit 1
  fi

  # The first 2 arguments is the toml files
  config_toml_file=$1
  config_contracts_toml_file=$2

  # The first argument is the service name
  service=$3
  shift 3

  # Function to extract and export variables
  extract_and_export() {
    local service=$1
    local source_var=$2
    local target_var=$3
    local value

    # Extract the value of the source variable from the toml files
    combined_toml=$(cat "$config_toml_file" "$config_contracts_toml_file")
    value=$(echo "$combined_toml" | grep -E "^${source_var} =" | sed 's/ *= */=/' | cut -d'=' -f2-)


    # Check if the value is found
    if [ -z "$value" ]; then
      echo "Warning: Variable $source_var not found in $toml_file"
      return
    fi

    # Add quotes around the value if it doesn't have already
    value=$(echo $value | sed -E 's/^([0-9]+)$/\"\1\"/')

    # Export the value as the target variable
    echo "$target_var: $value" >> charts/scroll-stack/configs/$service.env
  }

  # Loop through the source:target pairs
  for pair in "$@"; do
    IFS=':' read -r source_var target_var <<< "$pair"

    if [ -z "$source_var" ] || [ -z "$target_var" ]; then
      echo "Invalid pair: $pair. Skipping..."
      continue
    fi

    extract_and_export $service "$source_var" "$target_var"
  done

}

# List of services
# Note: frontend is excluded from this list as its env file is generated by the container scroll-stack-contracts.
services=("balance-checker" "bridge-history-api" "bridge-history-fetcher" "blockscout" "chain-monitor" "contracts" "coordinator" "gas-oracle" "l1-devnet" "l1-explorer" "l2-bootnode" "l2-rpc" "l2-sequencer" "rollup-node" "admin-system-backend")

# Loop over the list of services and execute the function
for service in "${services[@]}"; do
    get_service_variables $service
    env_file="charts/scroll-stack/configs/$service.env"
    delete_file_if_exists $env_file
    extract_from_config_toml $CONFIG_TOML $CONTRACT_CONFIG_TOML $service $(get_service_variables $service)
done
