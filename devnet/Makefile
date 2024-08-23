bootstrap:
		echo "Pulling helm chart..."
		helm pull oci://ghcr.io/scroll-tech/scroll-sdk/helm/scroll-sdk
		echo "Extracting helm chart..."
		tar -xvf *.tgz
		echo "Creating configuration files..."
		cd scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.16
		echo "Creating env files..."
		./create-env-files.sh scroll-sdk

install:
		helm upgrade -i scroll-sdk scroll-sdk/

reload-env-files:
		./create-env-files.sh scroll-sdk

delete:
		helm uninstall scroll-sdk

upgrade:
		helm upgrade scroll-sdk scroll-sdk/
