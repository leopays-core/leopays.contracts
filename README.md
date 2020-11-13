# LeoPays.Contracts

## Version : 0.1.0

The design of the LeoPays blockchain calls for a number of smart contracts that are run at a privileged permission level in order to support functions such as block producer registration and voting, token staking for CPU and network bandwidth, RAM purchasing, multi-sig, etc.  These smart contracts are referred to as the bios, system, msig, wrap (formerly known as sudo) and token contracts.

This repository contains examples of these privileged contracts that are useful when deploying, managing, and/or using an LeoPays blockchain.  They are provided for reference purposes:

   * [lpc.bios](./contracts/lpc.bios)
   * [lpc.system](./contracts/lpc.system)
   * [lpc.msig](./contracts/lpc.msig)
   * [lpc.wrap](./contracts/lpc.wrap)

The following unprivileged contract(s) are also part of the system.
   * [lpc.token](./contracts/lpc.token)

Dependencies:
* [LeoPays.CDT v0.1.x](https://github.com/leopays-core/leopays.cdt/releases/tag/v0.1.0)
* [LeoPays v0.1.x](https://github.com/leopays-core/leopays/releases/tag/v0.1.0) (optional dependency only needed to build unit tests)

To build the contracts follow the instructions in [`Build and deploy` section](./docs/02_build-and-deploy.md).

## License
[LICENSE](./LICENSE)
[EOSIO LICENSE](./eosio.contracts.license)
