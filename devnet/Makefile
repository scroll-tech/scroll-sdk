bootstrap:
		helm pull oci://ghcr.io/scroll-tech/scroll-sdk/helm/scroll-sdk
		bash create-env-files.sh
		cd charts/scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-sdk-contracts:gen-configs-v0.0.9

install:
		helm install scroll-sdk charts/scroll-sdk

deploy-contracts:
		cd charts/scroll-sdk && time docker run --rm -it -v .:/contracts/volume -v ./broadcast:/contracts/broadcast  --env-file ./configs/contracts.env --network host scrolltech/scroll-sdk-contracts:deploy-v0.0.9

reload-env-files:
		bash create-env-files.sh

uninstall:
		helm uninstall scroll-sdk

upgrade:
		helm upgrade scroll-sdk charts/scroll-sdk
