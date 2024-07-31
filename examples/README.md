# Scroll SDK Helper Scripts

This directory contains helper scripts for managing and interacting with your Scroll SDK deployment.

## Scripts

1. `l2-generate-txs.sh`: Generates transactions on the L2 network to produce more blocks.
2. `l1-generate-txs.sh`: Generates transactions on the L1 network to produce more blocks.
3. `clear-stuck-txs.sh`: Replaces transactions stuck in the mempool, useful when CCC gets overloaded.
4. `anvil-fund-accounts.sh`: Funds default L1 accounts when using an Anvil devnet.

## Dependencies

These scripts require the following dependencies:

1. [**yq**](https://mikefarah.gitbook.io/yq/): A lightweight command-line YAML processor.
   ```
   brew install yq
   ```

2. [**Foundry**](https://book.getfoundry.sh/): A toolkit for Ethereum application development.
   ```
   brew install foundry
   ```

## Usage

1. Ensure you have installed the required dependencies.
2. Make sure the scripts are executable:
   ```
   chmod +x examples/*.sh
   ```
3. Run a script from the repo root directory, for example:
   ```
   ./examples/l2-generate-txs.sh
   ```

Note: These scripts must be run from the root directory of the repository to ensure proper path resolution for the configuration file.

## Configuration

These scripts read configuration values from the `charts/scroll-stack/config.toml` file. Ensure this file is present and properly configured before running the scripts.

## Notes

- The `clear-stuck-txs.sh` script may need manual nonce setting in some cases.
- Always review and understand a script before running it, especially when it involves sending transactions or modifying account balances.

For more information on Scroll SDK, refer to the main README in the root directory of this repository.