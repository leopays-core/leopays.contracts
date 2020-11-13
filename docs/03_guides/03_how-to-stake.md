## Goal

Stake resource for your account

## Before you begin

* Install the currently supported version of leopays-cli

* Ensure the reference system contracts from `leopays.contracts` repository is deployed and used to manage system resources

* Understand the following:
  * What is an account
  * What is network bandwidth
  * What is CPU bandwidth

## Steps

Stake 0.01 LPC network bandwidth for `alice`

```shell
leopays-cli system delegatebw alice alice "0 LPC" "0.01 LPC"
```

Stake 0.01 LPC CPU bandwidth for `alice`:

```shell
leopays-cli system delegatebw alice alice "0.01 LPC" "0 LPC"
```