# bootstrap:
# 		bash helm-bootstrap.sh
# 		bash create-env-files.sh
# 		cd charts/scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.9

bootstrap:
		helm pull ../charts/blockscout

install-db:
		helm upgrade -i postgresql oci://registry-1.docker.io/bitnamicharts/postgresql --version 15.5.0 --values values/postgres.yaml

install:
		kubectl apply -f values/common.yaml
		helm upgrade -i l2-sequencer ../charts/l2-sequencer --values values/l2-sequencer.yaml
		helm upgrade -i coordinator-api ../charts/coordinator-api --values values/coordinator-api.yaml
		helm upgrade -i balance-checker ../charts/balance-checker
		helm upgrade -i blockscout ../charts/blockscout --values values/blockscout.yaml
		helm upgrade -i bridge-history-api ../charts/bridge-history-api --values values/bridge-history-api.yaml
		helm upgrade -i bridge-history-fetcher ../charts/bridge-history-fetcher --values values/bridge-history-fetcher.yaml
		helm upgrade -i chain-monitor ../charts/chain-monitor --values values/chain-monitor.yaml
		helm upgrade -i coordinator-cron ../charts/coordinator-cron --values values/coordinator-cron.yaml
		helm upgrade -i frontends ../charts/frontends --values values/frontends.yaml
		helm upgrade -i gas-oracle ../charts/gas-oracle --values values/gas-oracle.yaml
		helm upgrade -i l1-explorer ../charts/l1-explorer --values values/l1-explorer.yaml
		helm upgrade -i l2-bootnode ../charts/l2-bootnode --values values/l2-bootnode.yaml
		helm upgrade -i l2-rpc ../charts/l2-rpc --values values/l2-rpc.yaml
		helm upgrade -i rollup-explorer-backend ../charts/rollup-explorer-backend --values values/rollup-explorer-backend.yaml
		helm upgrade -i rollup-node ../charts/rollup-node --values  values/rollup-node.yaml
		helm upgrade -i rpc-gateway ../charts/rpc-gateway
		helm upgrade -i contracts ../charts/contracts

delete-all:
		helm delete balance-checker
		helm delete blockscout
		helm delete bridge-history-api
		helm delete bridge-history-fetcher
		helm delete chain-monitor
		helm delete coordinator-api
		helm delete coordinator-cron
		helm delete frontends
		helm delete gas-oracle
		helm delete l1-explorer
		helm delete l2-bootnode
		helm delete l2-rpc
		helm delete l2-sequencer
		helm delete rollup-explorer-backend
		helm delete rollup-node
		helm delete rpc-gateway
		helm delete scroll-sdk
