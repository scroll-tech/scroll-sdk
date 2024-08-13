# Production deployment
For production deployment, we recommend deploying each service one by one with helm.
Here are some key differences with a devnet environment :
- sensitive informations shall be stored in secrets. We provide helm templating for `external-secrets`, but you can use
another secret provider solution if you wish
- there is a dedicated values.yaml file for each service in the `values` folder. These overwrite some default behavior
of each chart, like the use of secret instead of a configmap.
- a configmap is associated with most of the service to add some environment variables. They have to be changed manually
for now
- some configurations are common to multiple services, like the genesis.json file or some scripts. You deploy them with
a chart in the production folder called scroll-common-config

Note :
we provide a basic database deployment in this folder, but we recommend hardening the database. The use of a managed
database can be a solution

## Needed secrets
- "scroll/balance-checker-config"
- "scroll/bridge-history-config"
- "scroll/chain-monitor-config"
- "scroll/coordinator-config"
- "scroll/rollup-config"
- "scroll/rollup-explorer-backend-config"
- "scroll/blockscout-env"
- "scroll/bridge-history-fetcher-env"
- "scroll/chain-monitor-env"
- "scroll/coordinator-env"
- "scroll/event-watcher-env"
- "scroll/l1-explorer-env"
- "scroll/l2-sequencer-env"
- "scroll/rollup-node-env"
- "scroll/gas-oracle-env"
- "scroll/frontends-config"
- "scroll/db"

Steps to prepare the environment :
1. complete config.toml file
2. run time docker run --rm -it -v .:/contracts/volume scrolltech/scroll-stack-contracts:gen-configs-v0.0.9 to generate the config for all services
3. from this folder, launch ./create-env-files.sh production to generate the environment variable files.
4. Create a new keystore for l2-sequencer and add these values to `l2-sequencer.secret.env` file
    - L2GETH_KEYSTORE
    - L2GETH_PASSWORD
    - L2GETH_NODEKEY

5. push the secrets to a secret manager
6. correct each file in the values/ folder to overwrite the default behavior of the chart. (ingress and env variables)

Deployment :
1. Deploy the database if you need to
2. Deploy each service, you can run `make install`
