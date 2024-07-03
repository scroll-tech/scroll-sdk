#!/bin/bash

CONFIG_TOML="charts/scroll-stack/config.toml"

# Function to get variables for a given service
get_service_variables() {
    local service_name=$1
    case "$service_name" in
        balance-checker)
            echo "CHAIN_ID_L1:SCROLL_L1_RPC CHAIN_ID_L2:SCROLL_L2_RPC"
            ;;
        blockscout)
            echo "CHAIN_ID_L2:CHAIN_ID BLOCKSCOUT_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        l1-devnet)
            echo "CHAIN_ID_L1:CHAIN_ID"
            ;;
        l1-explorer)
            echo "CHAIN_ID_L1:CHAIN_ID L1_EXPLORER_DB_CONNECTION_STRING:DATABASE_URL"
            ;;
        l2-bootnode)
            echo "CHAIN_ID_L2:CHAIN_ID"
            ;;
        l2-rpc)
            echo "CHAIN_ID_L2:CHAIN_ID"
            ;;
        l2-sequencer)
            echo "CHAIN_ID_L2:CHAIN_ID L2GETH_SIGNER_0_ADDRESS:L2GETH_SIGNER_ADDRESS"
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

  # The first argument is the service name
  service=$2
  shift 2

  # Function to extract and export variables
  extract_and_export() {
    local service=$1
    local source_var=$2
    local target_var=$3
    local value

    # Extract the value of the source variable from the toml file
    value=$(grep -E "^${source_var} =" "$toml_file" | sed 's/ *= */=/' | cut -d'=' -f2-)

    # Check if the value is found
    if [ -z "$value" ]; then
      echo "Warning: Variable $source_var not found in $toml_file"
      return
    fi

    # Export the value as the target variable
    echo "export $target_var=$value" >> charts/scroll-stack/configs/$service.env
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
services=("balance-checker" "blockscout" "l1-devnet" "l1-explorer" "l2-bootnode" "l2-rpc" "l2-sequencer")

# Loop over the list of services and execute the function
for service in "${services[@]}"; do
    get_service_variables $service
    rm charts/scroll-stack/configs/$service.env
    extract_from_config_toml $CONFIG_TOML $service $(get_service_variables $service)
done
