# Define variables for architecture-specific settings
ARCH_ARM64 := $(shell if [ "$$(uname -m)" = "arm64" ] || [ "$$(uname -m)" = "aarch64" ]; then echo "-arm64"; else echo ""; fi)
ARCH_OTHER := $(shell if [ "$$(uname -m)" != "arm64" ] && [ "$$(uname -m)" != "aarch64" ]; then echo "scroll-"; else echo ""; fi)
NAMESPACE ?= default
L2_IMAGE_TAG := $(ARCH_OTHER)v5.7.25$(ARCH_ARM64)
L1_RPC_HOST := l1-devnet.scrollsdk
SC_VERIFIER_TAG := $(if $(ARCH_ARM64),v1.7.0-arm,v1.7.0)

bootstrap:
		echo "Pulling helm chart..."
		helm pull oci://ghcr.io/scroll-tech/scroll-sdk/helm/scroll-sdk --version 0.1.3
		echo "Extracting helm chart..."
		tar -xvf *.tgz
		$(MAKE) config

config:
		echo "Creating configuration files..."
		cd scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-64934888f4cd002e77414a8e62812f70c00c5937
		echo "Creating env files..."
		./create-env-files.sh scroll-sdk
		./prepare-config-files.sh

install:
		helm upgrade -i scroll-sdk scroll-sdk -n $(NAMESPACE) \
			--set l2-rpc.image.tag=$(L2_IMAGE_TAG) \
			--set l2-sequencer.image.tag=$(L2_IMAGE_TAG) \
			--set l2-bootnode.image.tag=$(L2_IMAGE_TAG) \
			--set blockscout-sc-verifier.image.tag=$(SC_VERIFIER_TAG) \
			--set l1-devnet.ingress.main.hosts[0].host=$(L1_RPC_HOST) \
			--set l1-devnet.ingress.main.hosts[0].paths[0].path=/ \
			--set l1-devnet.ingress.main.hosts[0].paths[0].pathType=Prefix \
			--values scroll-sdk/admin-system-backend-config.yaml \
			--values scroll-sdk/admin-system-cron-config.yaml \
			--values scroll-sdk/balance-checker-config.yaml \
			--values scroll-sdk/bridge-history-api-config.yaml \
			--values scroll-sdk/bridge-history-fetcher-config.yaml \
			--values scroll-sdk/chain-monitor-config.yaml \
			--values scroll-sdk/coordinator-api-config.yaml \
			--values scroll-sdk/coordinator-cron-config.yaml \
			--values scroll-sdk/frontend-config.yaml \
			--values scroll-sdk/gas-oracle-config.yaml \
			--values scroll-sdk/genesis.yaml \
			--values scroll-sdk/rollup-explorer-backend-config.yaml \
			--values scroll-sdk/rollup-node-config.yaml \
			--values scroll-sdk/scroll-common-config.yaml \
			--values scroll-sdk/scroll-common-config-contracts.yaml

reload-env-files:
		./create-env-files.sh scroll-sdk

delete:
		helm uninstall scroll-sdk -n $(NAMESPACE)

upgrade:
		$(MAKE) install

verify:
		echo "Verifing contracts..."
		cd scroll-sdk && time docker run --rm -it --network="host" -v .:/contracts/volume scrolltech/scroll-stack-contracts:verify-64934888f4cd002e77414a8e62812f70c00c5937