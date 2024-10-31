# Scroll SDK
[![Twitter Follow](https://img.shields.io/twitter/follow/Scroll_ZKP?style=social)](https://twitter.com/Scroll_ZKP)
[![Discord](https://img.shields.io/discord/984015101017346058?color=%235865F2&label=Discord&logo=discord&logoColor=%23fff)](https://discord.gg/scroll)

## Introduction

Scroll SDK allows anyone to quickly deploy an instance of the Scroll zkEVM and its rollup architecture for deploying an L2 on Ethereum.

For more information, please see the [Scroll SDK Documentation](https://docs.scroll.io/en/sdk/) or our [launch announcement](https://scroll.io/blog/scroll-sdk-and-gadgets-building-the-foundation-for-ethereums-multichain-future).

## Repo
This repo contains:
- `ansible/playbooks`: Code for deploying provers on new machines (experimental)
- `charts/`: Helm charts used in deplying a Scroll SDK based chain using Kubernetes
- `custom-images/`: Docker images used for running a local devnet and as building base images
- `devnet/`: A quick start, basic configuration for setting up a local devnet
- `examples/`: Template files for use in your SDK project and helper scripts
  
Additional SDK tooling is available in our [scroll-sdk-cli](https://www.github.com/scroll-tech/scroll-sdk-cli) repo. This can also be installed locally by running `npm i -g @scroll-tech/scroll-sdk-cli` with node >= 18. More examples of its usage can be found in the deployment guides [here](https://scroll-sdk-init.docs.scroll.xyz/en/sdk/).

## Get Started

To get started using the repo, checkout our guides on running [a local devnet deployment](https://docs.scroll.io/en/sdk/guides/devnet-deployment/), [an alt-gas token testnet on Digital Ocean](https://docs.scroll.io/en/sdk/guides/digital-ocean-alt-gas-token/), an [AWS deployment](https://docs.scroll.io/en/sdk/guides/aws-deployment/), or see our [production deployment](https://docs.scroll.io/en/sdk/guides/production-deployment/) page.

## Third-Party Scroll SDK Charts

> [!NOTE]
> The following charts are developed and maintained by third parties. Please use with caution.

Proving Services:
- [Sindri](https://github.com/Sindri-Labs/sindri-scroll-sdk/)

## Other Scroll SDK Repos

- [Scroll SDK CLI](https://www.github.com/scroll-tech/scroll-sdk-cli)
- [Scroll Proving SDK](https://www.github.com/scroll-tech/scroll-proving-sdk)

## Contributing

The SDK is currently under heavy development, so if you wish to contribute, we recommend reaching out and coordinating closely with the Scroll team.

If you want to make custom modifications to any service, you can follow our guide on [Customizing SDK Components](https://docs.scroll.io/en/sdk/guides/customizing-sdk-components/).

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.
