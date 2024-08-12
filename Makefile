bootstrap:
		bash helm-bootstrap.sh
		bash create-env-files.sh
		cd charts/scroll-sdk && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.9

install:
		helm install scroll-sdk charts/scroll-sdkk

deploy-contracts:
		cd charts/scroll-sdk && time docker run --rm -it -v .:/contracts/volume -v ./broadcast:/contracts/broadcast  --env-file ./configs/contracts.env --network host scrolltech/scroll-stack-contracts:deploy-v0.0.9

reload-env-files:
		bash create-env-files.sh

uninstall:
		helm uninstall scroll-sdk

upgrade:
		helm upgrade scroll-sdk charts/scroll-sdk
