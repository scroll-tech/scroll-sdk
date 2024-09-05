# Scroll SDK
[![Twitter Follow](https://img.shields.io/twitter/follow/Scroll_ZKP?style=social)](https://twitter.com/Scroll_ZKP)
[![Discord](https://img.shields.io/discord/984015101017346058?color=%235865F2&label=Discord&logo=discord&logoColor=%23fff)](https://discord.gg/scroll)

> [!WARNING]
> Scroll SDK is experimental software and although ready for testnets, is not yet fully configured for production usage.

## Introduction

Scroll SDK allows anyone to quickly deploy an instance of the Scroll zkEVM and its rollup architecture for deploying an L2 on Ethereum.

For more information, please see this [Early Access Preview Documentation](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/).

## Repo
This repo contains:
- `charts/`: Helm charts for creating a Scroll SDK based chain using Kubernetes
- `ansible/playbooks`: Code for deploying provers on new machines(experimental)
- `custom-images/`: Docker images used for devnet and as base images
- `devnet/`: A basic configuration for setting up a local devnet
- `examples/`: Template files for use in your SDK project and helper scripts
  
Additional SDK tooling is available in our [scroll-sdk-cli](https://www.npmjs.com/package/scroll-sdk-cli) repo. This can also be installed locally by running `npm i -g scroll-sdk-cli` with node >= 18. More documentation for its usage is [here](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/).

## Get Started

To get started using the repo, checkout our guides on running [a local devnet deployment](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/guides/devnet-deployment/), [an alt-gas token testnet on Digital Ocean](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/guides/digital-ocean-alt-gas-token/), or see our [production deployment](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/guides/production-deployment/) page.

## Contributing

The SDK is currently under heavy development, so if you wish to contribute, we recommend reaching out and coordinating closely with the Scroll team.