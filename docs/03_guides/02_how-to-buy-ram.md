## Goal

Setup an account that require multiple signatures for signing a transaction

## Before you begin

* You have an account

* Ensure the reference system contracts from `leopays.contracts` repository is deployed and used to manage system resources

* You have sufficient token allocated to your account

* Install the currently supported version of leopays-cli

* Unlock your wallet

## Steps

Buys RAM in value of 0.1 LPC tokens for account `alice`:

```shell
leopays-cli system buyram alice alice "0.1 LPC" -p alice@active
```