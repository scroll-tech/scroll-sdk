# Scroll SDK
[![Twitter Follow](https://img.shields.io/twitter/follow/Scroll_ZKP?style=social)](https://twitter.com/Scroll_ZKP)
[![Discord](https://img.shields.io/discord/984015101017346058?color=%235865F2&label=Discord&logo=discord&logoColor=%23fff)](https://discord.gg/scroll)

> [!WARNING]
> Scroll SDK is a working name is currently available as an Early Access Preview for collaborators. It is experimental software and not yet configured for production usage.

## Introduction

Scroll SDK allows anyone to quickly deploy an instance of the Scroll zkEVM and its rollup architecture for deploying an L2 on Ethereum.

In the medium term, it will allow for robust customization of an L2, including customizing its DA layer, base/settlement layer, native gas token, bridge logic, and more. Our goal is to build a robust stack focused on sovereignty and adaptability, with simple upgradability and flexible proof generation, all without locking new chains into shared governance, common asset pools, or business-source licensing.

For more information, please see this [Early Access](https://scrollzkp.notion.site/Scroll-SDK-Early-Access-Feedback-Request-74272ce6a0ae4c1d8f5c1d836df1f410?pvs=4) document. To provide feedback, reach out or use [this form](https://tally.so/r/3xQdNr).

## Repo
This repo hosts a Helm chart for deploying a Scroll SDK chain. 
It also provides a database and a monitoring stack based on Prometheus, Loki and Grafana.

The current configuration supports running a devnet but is not yet optimized for production.

## Prerequisites
Before getting started, be sure to install the following:
- [Docker Engine](https://docs.docker.com/engine/install/) (or Docker Desktop)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [minikube](https://minikube.sigs.k8s.io/docs/start/) (for local dev cluster)
- [Helm](https://helm.sh/docs/intro/install/)

## Bootstrap
### Get Helm dependencies
Add the [bjw-s repo](https://github.com/bjw-s/helm-charts) to your Helm repo:
```bash
helm repo add bjw-s https://bjw-s.github.io/helm-charts
```
Run the following script to get the dependencies of each Helm chart:
```bash
./helm-bootstrap.sh
```

### Generate the config files
Run this command to generate a `config.toml` file and genesis file:
```bash
cd charts/scroll-stack
time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-53d0389b


## Launch Scroll SDK
Run this from the `charts/scroll-stack` folder:
```bash
helm install scroll-stack . 
```

Run `kubectl get pods` to confirm the status of running services.

## Web UIs & Monitoring

Accessing browser UIs from your machine will depend on your configuration. The examples below show how to temporarily forward ports or configure `/etc/hosts` for access.

### Bridge Frontend & Rollup Explorer

#### Using port-forward

```bash
kubectl port-forward svc/frontends 8082:80
```

  After starting the project, then go to your browser and check `http://localhost:8082/`

#### Using /etc/hosts
If you enabled ingress on your cluster, you can add the following entries:

```txt
1.2.3.4    frontends.scrollsdk
```

where `1.2.3.4` is the IP of your cluster.

Then go to your browser and check `http://frontends.scrollsdk/`

### Blockscout
Accessing Blockscout depends on your configuration.

#### Using port-forward

```bash
kubectl port-forward svc/blockscout 8080:3000
```

  After starting the project, then go to your browser and check `http://localhost:8080/`

#### Using /etc/hosts
If you enabled ingress on your cluster, you can add the following entries:

```txt
1.2.3.4    blockscout.scrollsdk
```

where `1.2.3.4` is the IP of your cluster.

Then go to your browser and check `http://blockscout.scrollsdk/`

### Grafana
#### Using port-forward

```bash
kubectl port-forward svc/grafana 8081:80
```
Then go to your browser and check `http://localhost:8081/`

#### Using /etc/hosts

If you enabled ingress on your cluster, you can add the following entries:

```txt
1.2.3.4    grafana.scrollsdk
```

where `1.2.3.4` is the IP of your cluster.
Then go to your browser and check `http://grafana.scrollsdk/`

## Changing the database endpoint

If you don't want to use the Postgres database provided in this chart, you configure your own database.

1. Change the values in the value.yaml file:

    ```txt
    db:
      pg_host: "postgresql"
      pg_user: "postgres"
      pg_password: "qwerty12345"
      pg_port: "5432"
      bridge_history_password: "test1234"
      chain_monitor_password: "test1234"
      event_watcher_password: "test1234"
      gas_oracle_password: "test1234"
      rollup_node_password: "test1234"
      rpc_gateway_password: "test1234"
    ```
    _Note: the user for each service will be created but is not used yet by the service. Every service uses the admin account._

2. Change the `config.toml` file

    Provide the correct db string on the DB section.
