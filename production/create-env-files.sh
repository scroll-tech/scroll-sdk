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
        balance-checker)
            echo "CHAIN_ID_L1:SCROLL_L1_RPC CHAIN_ID_L2:SCROLL_L2_RPC"
            ;;
        blockscout)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC"
            ;;
        bridge-history-api)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC  L2_RPC_ENDPOINT:SCROLL_L2_RPC"
            ;;
        bridge-history-fetcher)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC L2_RPC_ENDPOINT:SCROLL_L2_RPC"
            ;;
        chain-monitor)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC"
            ;;
        contracts)
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT CHAIN_ID_L1:CHAIN_ID_L1 CHAIN_ID_L2:CHAIN_ID_L2"
            ;;
        coordinator)
            echo "DATABASE_HOST:DATABASE_HOST DATABASE_PORT:DATABASE_PORT"
            ;;
        event-watcher)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC"
            ;;
        gas-oracle)
            echo "L1_RPC_ENDPOINT:SCROLL_L1_RPC"
            ;;
        l1-devnet)
            echo "CHAIN_ID_L1:CHAIN_ID"
            ;;
        l1-explorer)
            echo "CHAIN_ID_L1:CHAIN_ID L1_EXPLORER_DB_CONNECTION_STRING:DATABASE_URL L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_HTTP_URL L1_RPC_ENDPOINT:ETHEREUM_JSONRPC_TRACE_URL L1_RPC_ENDPOINT:JSON_RPC L1_RPC_ENDPOINT_WEBSOCKET:ETHEREUM_JSONRPC_WS_URL"
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
            echo "L1_RPC_ENDPOINT:L1_RPC_ENDPOINT L2_RPC_ENDPOINT:L2_RPC_ENDPOINT"
            ;;
        *)
            echo "Service $service_name not found."
            ;;
    esac
}

get_service_secret_variables() {
    local service_name=$1
    case "$service_name" in
        blockscout)
            echo "BLOCKSCOUT_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        bridge-history-fetcher)
            echo "BRIDGE_HISTORY_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        chain-monitor)
            echo "CHAIN_MONITOR_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        coordinator)
            echo "COORDINATOR_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        event-watcher)
            echo "EVENT_WATCHER_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        gas-oracle)
            echo "AS_ORACLE_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        l1-explorer)
            echo "L1_EXPLORER_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        rollup-node)
            echo "ROLLUP_NODE_DB_CONNECTION_STRING:DATABASE_URL"
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

  # The second argument is the service name
  service=$2

  # The third argument is the file to export
  file=$3

  # The rest is the key/value pair
  shift 3


  # Function to extract and export variables
  extract_and_export() {
    local service=$1
    local source_var=$2
    local target_var=$3
    local file=$4
    local value

    # Extract the value of the source variable from the toml file
    value=$(grep -E "^${source_var} =" "$toml_file" | sed 's/ *= */=/' | cut -d'=' -f2-)

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

# Function to search for a key in the source file, get its value, and write it to the target file with the given new value.
#update_value_in_file() {
#  local key_value_pair=$1
#  local source_file=$2
#  local target_file=$3
#
#  # Split the key-value pair into key and new value
#  IFS=':' read -r key new_key <<< "$key_value_pair"
#
#  # Check if the key exists in the source file
#  echo "key is $key"
#  if grep -q "^$key =" "$source_file"; then
#      # Extract the current value from the source file
#      current_value=$(grep "^$key =" "$source_file" | cut -d '=' -f 2)
#
#      # Write the key with the new value to the target file
#      #echo "$key=$new_value" >> "$target_file"
#      #sed -i 's|$new_key: "l1_rpc_url"|$new_key: "$current_value"|' $target_file
#      sed -i "s/^${new_key}=.*/${new_key}=\"$current_value\"/" "$target_file"
#
#      echo "Key '$key' found in $source_file with value '$current_value'. Updated with new value '$new_value' in $target_file."
#  else
#      echo "Key '$key' not found in $source_file."
#  fi
#}
update_key_value() {
    # Parameters
    local config_file=$1
    local new_file=$2
    local mapping=$3

    echo "Config file: $config_file"
    echo "Target file: $new_file"
    echo "Mapping: $mapping"

    # Parse the mapping into old_key and new_key
    local old_key="${mapping%%:*}"
    local new_key="${mapping##*:}"

    echo "Old key: $old_key"
    echo "New key: $new_key"

    # Initialize value
    local value=""

    # Read the key-value pair from the config file
    while IFS= read -r line; do
        echo "Processing line: '$line'"

        # Trim leading/trailing whitespace
        line=$(echo "$line" | sed 's/^[ \t]*//;s/[ \t]*$//')

        # Skip empty lines or lines that are comments
        if [[ -z "$line" || "$line" =~ ^# ]]; then
            continue
        fi

        # Match the key-value pattern
        if [[ "$line" == "$old_key"* ]]; then
            echo "Match found: $line"
            value=$(echo "$line" | sed -E "s/^$old_key\s*=\s*\"(.*)\"/\1/")
            echo "Extracted value: $value"
            break
        fi
    done < "$config_file"

    # Check if the value was found
    if [ -n "$value" ]; then
        # Escape special characters for sed
        escaped_value=$(printf '%s\n' "$value" | sed 's/[&/\]/\\&/g')
        echo "escaped value is $escaped_value"

        echo "Updating target file with value: $escaped_value"
        # If the new key already exists in the new file, update it
        if grep -q "^\s*${new_key}:" "$new_file"; then
            echo "Updating existing key in target file."
            # Update the existing key-value pair
            sed -i '' 's/^\(${new_key}:\) ""/\1 "$escaped_value"/' "$new_file"
        else
            echo "Appending new key-value pair to target file."
            # Append the new key-value pair
            echo "    ${new_key}: \"$escaped_value\"" >> "$new_file"
        fi
    else
        echo "Key $old_key not found in config file."
    fi
}

# List of services
# Note: frontend is excluded from this list as its env file is generated by the container scroll-stack-contracts.
services_configmap=("balance-checker" "bridge-history-api" "bridge-history-fetcher" "blockscout" "chain-monitor" "contracts" "coordinator" "event-watcher" "gas-oracle" "l1-devnet" "l1-explorer" "l2-bootnode" "l2-rpc" "l2-sequencer" "rollup-node")
services_secret=("bridge-history-fetcher" "blockscout" "chain-monitor" "coordinator" "event-watcher" "gas-oracle" "l1-explorer" "l2-sequencer" "rollup-node")

# Loop over the list of services and execute the function
for service in "${services_configmap[@]}"; do
    get_service_configmap_variables $service
    env_file="$CHART_DIR/configs/$service.env"
    delete_file_if_exists $env_file
    extract_from_config_toml $CHART_DIR/config.toml $service $CHART_DIR/configs/$service.env $(get_service_configmap_variables $service)
done

for service in "${services_secret[@]}"; do
    get_service_secret_variables $service
    env_file="$CHART_DIR/configs/$service.secret.env"
    delete_file_if_exists $env_file
    extract_from_config_toml $CHART_DIR/config.toml $service $CHART_DIR/secrets/$service.secret.env $(get_service_secret_variables $service)
done
