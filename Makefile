bootstrap:
		bash helm-bootstrap.sh
		bash create-env-files.sh
		cd charts/scroll-stack && time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.14-gas-token


install:
		helm install scroll-stack charts/scroll-stack

deploy-contracts:
		cd charts/scroll-stack && time docker run --rm -it -v .:/contracts/volume -v ./broadcast:/contracts/broadcast  --env-file ./configs/contracts.env --network host scrolltech/scroll-stack-contracts:deploy-v0.0.14-gas-token


reload-env-files:
		bash create-env-files.sh

uninstall:
		helm uninstall scroll-stack

upgrade:
		helm upgrade scroll-stack charts/scroll-stack