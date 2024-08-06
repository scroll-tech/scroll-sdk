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

> [!Note]
> Looking to run a local testnet on an amd64 mac? Please follow [this guide](https://scrollzkp.notion.site/Guide-Running-Scroll-SDK-on-an-ARM64-Mac-36bdf4f3ee2345bf9d1ea6e62f9fcf08#e40ae30777ec4dd083e71d37ead1a185)!

Before getting started, be sure to install the following:
- [Docker Engine](https://docs.docker.com/engine/install/) (or Docker Desktop)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [minikube](https://minikube.sigs.k8s.io/docs/start/) (for local dev cluster)
- [Helm](https://helm.sh/docs/intro/install/)
- `make` command

## Bootstrap
Run the following command to bootstrap helm and the config files:
```bash
make bootstrap
```

## Launch Scroll SDK
Run this from the `charts/scroll-sdk` folder:
```bash
helm install scroll-sdk .
```

Run `kubectl get pods` to confirm the status of running services.

## Web UIs, Monitoring and Exposed Services

Accessing services and UIs from your machine will depend on your configuration. 3 possible configurations are described below.

If using the default DNS names, the following services will be available locally after configuring and launching your Scroll SDK chain:

- Block Explorers (Blockscout)
    - [L2 Explorer](http://blockscout.scrollsdk/)
    - [L1 Explorer](http://l1-devnet-explorer.scrollsdk/) *(this is scanning Anvil and can be a bit buggy)*
- [Bridge](http://frontends.scrollsdk/bridge)
- [Rollup Explorer](http://frontends.scrollsdk/rollupscan?page=1&per_page=10)
    - Shows committed batches and finalized batches
    - ***API NOT CURRENTLY WORKING AS OF June 17, 2024***
- [Granfana Dashboards](http://grafana.scrollsdk/)
    - Login
        - User: `admin`
        - Pass: `scroll-sdk`
    - See “Scroll” dashboards on [this page](http://grafana.scrollsdk/dashboards).

### Access on macOS using minikube and `ingress-dns`

Our [guide for mac](https://scrollzkp.notion.site/Guide-Running-Scroll-SDK-on-an-ARM64-Mac-36bdf4f3ee2345bf9d1ea6e62f9fcf08#e40ae30777ec4dd083e71d37ead1a185) includes how to use minikube with `ingress-dns`. We have not tested this configuration for Linux desktops.

The key steps include installing [docker-mac-net-connect](https://github.com/chipmk/docker-mac-net-connect) and running the following:

```bash
minikube ssh "sudo apt-get update && sudo apt-get -y install qemu-user-static"
minikube addons enable ingress
minikube addons enable ingress-dns
sudo brew services start chipmk/tap/docker-mac-net-connect
```

Then, configure `/etc/resolver/minikube-scrollsdk`

```text
domain scrollsdk
nameserver <minikube_ip>
search_order 1
timeout 5
```

Lastly, flush your DNS and test:

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
nslookup frontends.scrollsdk $(minikube ip)
```

### Access using /etc/hosts

If you have enabled ingress on your cluster and are not using `ingress-dns`, add the following entries, replacing `1.2.3.4` with the IP of your cluster.

```txt
1.2.3.4 l1-devnet.scrollsdk
1.2.3.4 bridge-history.scrollsdk
1.2.3.4 frontends.scrollsdk
1.2.3.4 grafana.scrollsdk
1.2.3.4 l1-devnet-explorer.scrollsdk
1.2.3.4 l2-rpc.scrollsdk
1.2.3.4 blockscout.scrollsdk
1.2.3.4 bridge-history-api.scrollsdk
```

### Access using port-forward

If you want to quickly expose a single source, you can use `port-forward` to expose a service in your cluster.

For example, to access the Grafana dashboards, open a new terminal session and run

```bash
kubectl port-forward svc/grafana 8081:80
```

Then go to your browser and check `http://localhost:8081/`. You'll need to leave your terminal session running to maintain access.

For other services, replace `svc/grafana` with the appropriate service name and `8081:80` to the correct ports. The first port should be the port number you want to request on your local machine. The second can be found in the `charts/[service]/values.yaml` file in the `service -> main -> ports -> http -> port` field.

```yaml
service:
  main:
    enabled: true
    ports:
      http:
        enabled: true
        port: 3000
```

Other examples:
- `kubectl port-forward svc/frontends 8082:80`
- `kubectl port-forward svc/blockscout 8080:3000`
- `kubectl port-forward svc/l2-rpc 8083:8545`

> [!WARNING]
> This method will not work for the `frontends` service and bridge UIs out-of-the box. You'll need to re-configure the values so that RPC and API calls from the browser are sent to accessible URIs (ie other localhost ports).

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
