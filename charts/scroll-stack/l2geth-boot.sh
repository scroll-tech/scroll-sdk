#!/bin/bash

# Check if L2GETH_ROLE is set
if [ -z "$L2GETH_ROLE" ]; then
  echo "Error: L2GETH_ROLE is not set"
  exit 1
fi

# Default values for verbosity and CCC_FLAG
VERBOSITY=${VERBOSITY:-3}
CCC_FLAG=${CCC_FLAG:-""}

# Common command options
COMMON_OPTS=(
  --datadir "/l2geth/data"
  --port "$L2GETH_P2P_PORT"
  --syncmode full
  --networkid "$CHAIN_ID"
  --gcmode archive
  --cache.noprefetch
  --verbosity "$VERBOSITY"
  --txpool.globalqueue 4096
  --txpool.globalslots 40960
  --txpool.pricelimit "$L2GETH_MIN_GAS_PRICE"
  --miner.gasprice "$L2GETH_MIN_GAS_PRICE"
  --rpc.gascap 0
  --gpo.ignoreprice "$L2GETH_MIN_GAS_PRICE"
  --metrics --metrics.expensive
  $CCC_FLAG
  $LOCALS_FLAG
  $METRICS_FLAGS
  --l1.endpoint "$L2GETH_L1_ENDPOINT"
  --l1.confirmations "$L2GETH_L1_WATCHER_CONFIRMATIONS"
  --l1.sync.startblock "$L2GETH_L1_CONTRACT_DEPLOYMENT_BLOCK"
  $L2GETH_EXTRA_PARAMS
)

# Role specific options
case "$L2GETH_ROLE" in
  rpc)
    ROLE_OPTS=(
      --config "/l2geth/config.toml"
      --nodiscover
      --http --http.port "$L2GETH_RPC_HTTP_PORT" --http.addr "0.0.0.0" --http.vhosts="*" --http.corsdomain '*' --http.api "eth,scroll,net,web3,debug"
      --pprof --pprof.addr "0.0.0.0" --pprof.port 6060
      --ws --ws.port "$L2GETH_RPC_WS_PORT" --ws.addr "0.0.0.0" --ws.api "eth,scroll,net,web3,debug"
      --gpo.percentile 20
      --gpo.blocks 100
      --rollup.verify
    )
    ;;
  bootnode)
    ROLE_OPTS=(
      --config "/l2geth/config.toml"
      --maxpeers "$L2GETH_MAX_PEERS"
      --netrestrict "$L2GETH_NETRESTRICT"
      --nat "$L2GETH_NAT"
      --bootnodes ""
      --pprof --pprof.addr "0.0.0.0" --pprof.port 6060
    )
    ;;
  sequencer)
    ROLE_OPTS=(
      --nodiscover
      --http --http.port "$L2GETH_RPC_HTTP_PORT" --http.addr "0.0.0.0" --http.vhosts="*" --http.corsdomain '*' --http.api "eth,scroll,net,web3,debug"
      --pprof --pprof.addr "0.0.0.0" --pprof.port 6060
      --ws --ws.port "$L2GETH_RPC_WS_PORT" --ws.addr "0.0.0.0" --ws.api "eth,scroll,net,web3,debug"
      --unlock "$L2GETH_SIGNER_ADDRESS" --password "/l2geth/password" --allow-insecure-unlock --mine
      --gpo.percentile 20
      --gpo.blocks 100
      --rollup.verify
    )
    ;;
  *)
    echo "Error: Unknown L2GETH_ROLE value '$L2GETH_ROLE'"
    exit 1
    ;;
esac

if [ $L2GETH_ROLE == "bootnode" ] || [ $L2GETH_ROLE == "rpc" ]
then
  echo "[Node.P2P] StaticNodes = $L2GETH_PEER_LIST" > "/l2geth/config.toml"
  geth --datadir "/l2geth/data" init /l2geth/genesis/genesis.json
  echo "Launching l2geth with this command: "
  echo "geth \"${COMMON_OPTS[@]}\" \"${ROLE_OPTS[@]}\""
  geth "${COMMON_OPTS[@]}" "${ROLE_OPTS[@]}"
elif [ $L2GETH_ROLE == "sequencer" ]; then
    mkdir -p /l2geth/data/keystore
    mkdir -p /l2geth/data/geth
    echo ${L2GETH_PASSWORD} > /l2geth/password
    echo ${L2GETH_KEYSTORE}  > /l2geth/data/keystore/keystore.json
    echo ${L2GETH_NODEKEY} > /l2geth/data/geth/nodekey
    geth --datadir "/l2geth/data" init /l2geth/genesis/genesis.json
    echo "Launching l2geth with this command: "
    echo "geth \"${COMMON_OPTS[@]}\" \"${ROLE_OPTS[@]}\""
    geth "${COMMON_OPTS[@]}" "${ROLE_OPTS[@]}"
else
  echo "L2GETH_ROLE is not set to bootnode,rpc or sequencer. Exiting."
fi