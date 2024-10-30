#!/bin/bash
# This script creates a dedicated env file for each service needing it from the config.toml file
# We hence centralize the configuration of the services on the config.toml file.

CHART_DIR=$1

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
get_service_configmap_variables() {
    local service_name=$1
    case "$service_name" in
        admin-system-backend)
            echo "ROLLUP_NODE_DB_CONNECTION_STRING:SCROLL_ADMIN_DB_CONFIG_DSN ROLLUP_NODE_DB_CONNECTION_STRING:SCROLL_ADMIN_READ_ONLY_DB_CONFIG_DSN ADMIN_SYSTEM_BACKEND_DB_CONNECTION_STRING:SCROLL_ADMIN_AUTH_DB_CONFIG_DSN"
            ;;
        balance-checker)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC L2_RPC_ENDPOINT:SCROLL_L2_RPC"
            ;;
        blockscout)
            echo "L1_RPC_ENDPOINT:INDEXER_SCROLL_L1_RPC BLOCKSCOUT_DB_CONNECTION_STRING:DATABASE_URL L1_SCROLL_CHAIN_PROXY_ADDR:INDEXER_SCROLL_L1_CHAIN_CONTRACT L1_CONTRACT_DEPLOYMENT_BLOCK:INDEXER_SCROLL_L1_BATCH_START_BLOCK L1_SCROLL_MESSENGER_PROXY_ADDR:INDEXER_SCROLL_L1_MESSENGER_CONTRACT L1_CONTRACT_DEPLOYMENT_BLOCK:INDEXER_SCROLL_L1_MESSENGER_START_BLOCK L2_SCROLL_MESSENGER_PROXY_ADDR:INDEXER_SCROLL_L2_MESSENGER_CONTRACT L1_GAS_PRICE_ORACLE_ADDR:INDEXER_SCROLL_L2_GAS_ORACLE_CONTRACT"
            ;;
        bridge-history-api)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC  L2_RPC_ENDPOINT:SCROLL_L2_RPC BRIDGE_HISTORY_DB_CONNECTION_STRING:SCROLL_BRIDGE_HISTORY_DB_DSN"
            ;;
        bridge-history-fetcher)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC L2_RPC_ENDPOINT:SCROLL_L2_RPC BRIDGE_HISTORY_DB_CONNECTION_STRING:SCROLL_BRIDGE_HISTORY_DB_DSN"
            ;;
        chain-monitor)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC CHAIN_MONITOR_DB_CONNECTION_STRING:SCROLL_CHAIN_MONITOR_DB_CONFIG_DSN L1_SCROLL_CHAIN_PROXY_ADDR:L1_SCROLL_CHAIN_PROXY_ADDR"
            ;;
        contracts)
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT CHAIN_ID_L1:CHAIN_ID_L1 CHAIN_ID_L2:CHAIN_ID_L2"
            ;;
        coordinator)
            echo "COORDINATOR_DB_CONNECTION_STRING:SCROLL_COORDINATOR_DB_DSN"
            ;;
        gas-oracle)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC GAS_ORACLE_DB_CONNECTION_STRING:SCROLL_ROLLUP_DB_CONFIG_DSN L2_GAS_ORACLE_SENDER_PRIVATE_KEY:SCROLL_ROLLUP_L1_CONFIG_RELAYER_CONFIG_GAS_ORACLE_SENDER_SIGNER_CONFIG_PRIVATE_KEY_SIGNER_CONFIG_PRIVATE_KEY L1_GAS_ORACLE_SENDER_PRIVATE_KEY:SCROLL_ROLLUP_L2_CONFIG_RELAYER_CONFIG_GAS_ORACLE_SENDER_SIGNER_CONFIG_PRIVATE_KEY_SIGNER_CONFIG_PRIVATE_KEY"
            ;;
        l1-devnet)
            echo "CHAIN_ID_L1:CHAIN_ID"
            ;;
        l1-explorer)
            echo "CHAIN_ID_L1:CHAIN_ID L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_HTTP_URL L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_TRACE_URL L1_RPC_ENDPOINT:JSON_RPC L1_RPC_ENDPOINT_WEBSOCKET:ETHEREUM_JSONRPC_WS_URL L1_EXPLORER_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        l2-bootnode)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT L2_GETH_STATIC_PEERS:L2GETH_PEER_LIST L1_CONTRACT_DEPLOYMENT_BLOCK:L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK"
            ;;
        l2-rpc)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT L1_CONTRACT_DEPLOYMENT_BLOCK:L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK L2_GETH_STATIC_PEERS:L2GETH_PEER_LIST"
            ;;
        l2-sequencer)
            echo "CHAIN_ID_L2:CHAIN_ID L1_RPC_ENDPOINT:L2GETH_L1_ENDPOINT L2GETH_SIGNER_ADDRESS:L2GETH_SIGNER_ADDRESS L1_CONTRACT_DEPLOYMENT_BLOCK:L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK L2GETH_KEYSTORE:L2GETH_KEYSTORE L2GETH_PASSWORD:L2GETH_PASSWORD L2GETH_NODEKEY:L2GETH_NODEKEY L2_GETH_STATIC_PEERS:L2GETH_PEER_LIST"
            ;;
        rollup-node)
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT ROLLUP_NODE_DB_CONNECTION_STRING:SCROLL_ROLLUP_DB_CONFIG_DSN L1_SCROLL_CHAIN_PROXY_ADDR:L1_SCROLL_CHAIN_PROXY_ADDR L1_COMMIT_SENDER_PRIVATE_KEY:SCROLL_ROLLUP_L2_CONFIG_RELAYER_CONFIG_COMMIT_SENDER_SIGNER_CONFIG_PRIVATE_KEY_SIGNER_CONFIG_PRIVATE_KEY L1_FINALIZE_SENDER_PRIVATE_KEY:SCROLL_ROLLUP_L2_CONFIG_RELAYER_CONFIG_FINALIZE_SENDER_SIGNER_CONFIG_PRIVATE_KEY_SIGNER_CONFIG_PRIVATE_KEY"
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

  # The first argument is the toml file
  toml_file=$1

  # The second argument is the toml file
  toml_contracts_file=$2

  # The third argument is the service name
  service=$3

  # The fourth argument is the file to export
  file=$4

  # The rest is the key/value pair
  shift 4


  # Function to extract and export variables
  extract_and_export() {
    local service=$1
    local source_var=$2
    local target_var=$3
    local file=$4
    local value

    # Extract the value of the source variable from the toml file
    value=$(grep -E "^${source_var} =" "$toml_file" | sed 's/ *= */=/' | cut -d'=' -f2-)

    # Check if the value is found in config.toml, otherwise look in config-contract.toml
    if [ -z "$value" ]; then
      echo "Variable $source_var not found in $toml_file, looking in $toml_contracts_file..."
      value=$(grep -E "^${source_var} =" "$toml_contracts_file" | sed 's/ *= */=/' | cut -d'=' -f2-)
    fi

    # Check if the value is found
    if [ -z "$value" ]; then
      echo "Warning: Variable $source_var not found in $toml_file"
      return
    fi

    # Add quotes around the value if it doesn't have already
    value=$(echo $value | sed -E 's/^([0-9]+)$/\"\1\"/')

    # Export the value as the target variable
    echo "$target_var: $value" >> $file
  }

  # Loop through the source:target pairs
  for pair in "$@"; do
    IFS=':' read -r source_var target_var <<< "$pair"

    if [ -z "$source_var" ] || [ -z "$target_var" ]; then
      echo "Invalid pair: $pair. Skipping..."
      continue
    fi

    extract_and_export $service "$source_var" "$target_var" $file
  done

}

# List of services
# Note: frontend is excluded from this list as its env file is generated by the container scroll-stack-contracts.
services_configmap=("admin-system-backend" "balance-checker" "bridge-history-api" "bridge-history-fetcher" "blockscout" "chain-monitor" "contracts" "coordinator" "gas-oracle" "l1-devnet" "l1-explorer" "l2-bootnode" "l2-rpc" "l2-sequencer" "rollup-node")

# Loop over the list of services and execute the function
for service in "${services_configmap[@]}"; do
    get_service_configmap_variables $service
    env_file="$CHART_DIR/configs/$service.env"
    delete_file_if_exists $env_file
    extract_from_config_toml $CHART_DIR/config.toml $CHART_DIR/config-contracts.toml $service $CHART_DIR/configs/$service.env $(get_service_configmap_variables $service)
done
