bootstrap:
		echo "Pulling helm chart..."
		helm pull oci://ghcr.io/scroll-tech/scroll-sdk/helm/scroll-sdk
		echo "Extracting helm chart..."
		tar -xvf *.tgz
		echo "Creating env files..."
		cd ../ && ./create-env-files.sh devnet/scroll-sdk
		echo "Creating configuration files..."
		cd scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.9

install:
		helm install scroll-sdk scroll-sdk/

deploy-contracts:
		cd scroll-sdk && time docker run --rm -it -v .:/contracts/volume -v ./broadcast:/contracts/broadcast  --env-file ./configs/contracts.env --network host scrolltech/scroll-stack-contracts:deploy-v0.0.9

reload-env-files:
		cd ../ && ./create-env-files.sh devnet/scroll-sdk

uninstall:
		helm uninstall scroll-sdk

upgrade:
		helm upgrade scroll-sdk scroll-sdk/
