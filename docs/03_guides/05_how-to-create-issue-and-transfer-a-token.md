## How to create, issue and transfer a token

## Step 1: Obtain Contract Source

Navigate to your contracts directory.

```text
cd CONTRACTS_DIR
```

Pull the source
```text
git clone https://github.com/leopays-core/leopays.contracts --branch master --single-branch
```

```text
cd leopays.contracts/contracts/lpc.token
```

## Step 2: Create Account for Contract
[[info]]
| You may have to unlock your wallet first!

```shell
leopays-cli create account lpc lpc.token LPC6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
```

## Step 3: Compile the Contract

```shell
leopays-cpp -I include -o lpc.token.wasm src/lpc.token.cpp --abigen
```

## Step 4: Deploy the Token Contract

```shell
leopays-cli set contract lpc.token CONTRACTS_DIR/leopays.contracts/contracts/lpc.token --abi lpc.token.abi -p lpc.token@active
```

Result should look similar to the one below:
```shell
Reading WASM from ...
Publishing contract...
executed transaction: 69c68b1bd5d61a0cc146b11e89e11f02527f24e4b240731c4003ad1dc0c87c2c  9696 bytes  6290 us
#         lpc <= lpc::setcode               {"account":"lpc.token","vmtype":0,"vmversion":0,"code":"0061736d0100000001aa011c60037f7e7f0060047f...
#         lpc <= lpc::setabi                {"account":"lpc.token","abi":"0e656f73696f3a3a6162692f312e30000605636c6f73650002056f776e6572046e61...
warning: transaction executed locally, but may not be confirmed by the network yet         ]
```

## Step 5: Create the Token

```shell
leopays-cli push action lpc.token create '[ "lpc", "1000000000.0000 LPC"]' -p lpc.token@active
```

Result should look similar to the one below:
```shell
executed transaction: 0e49a421f6e75f4c5e09dd738a02d3f51bd18a0cf31894f68d335cd70d9c0e12  120 bytes  1000 cycles
#   lpc.token <= lpc.token::create          {"issuer":"lpc","maximum_supply":"1000000000.0000 LPC"}
```

An alternate approach uses named arguments:

```shell
leopays-cli push action lpc.token create '{"issuer":"lpc", "maximum_supply":"1000000000.0000 LPC"}' -p lpc.token@active
```

Result should look similar to the one below:
```shell
executed transaction: 0e49a421f6e75f4c5e09dd738a02d3f51bd18a0cf31894f68d335cd70d9c0e12  120 bytes  1000 cycles
#   lpc.token <= lpc.token::create          {"issuer":"lpc","maximum_supply":"1000000000.0000 LPC"}
```
This command created a new token `LPC` with a precision of 4 decimals and a maximum supply of 1000000000.0000 LPC.  To create this token requires the permission of the `lpc.token` contract. For this reason, `-p lpc.token@active` was passed to authorize the request.

## Step 6: Issue Tokens

The issuer can issue new tokens to the issuer account in our case `lpc`. 

```text
leopays-cli push action lpc.token issue '[ "lpc", "100.0000 LPC", "memo" ]' -p lpc@active
```

Result should look similar to the one below:
```shell
executed transaction: a26b29d66044ad95edf0fc04bad3073e99718bc26d27f3c006589adedb717936  128 bytes  337 us
#   lpc.token <= lpc.token::issue           {"to":"lpc","quantity":"100.0000 LPC","memo":"memo"}
warning: transaction executed locally, but may not be confirmed by the network yet         ]
```

## Step 7: Transfer Tokens

Now that account `lpc` has been issued tokens, transfer some of them to account `bob`.

```shell
leopays-cli push action lpc.token transfer '[ "lpc", "bob", "25.0000 LPC", "m" ]' -p lpc@active
```

Result should look similar to the one below:
```text
executed transaction: 60d334850151cb95c35fe31ce2e8b536b51441c5fd4c3f2fea98edcc6d69f39d  128 bytes  497 us
#   lpc.token <= lpc.token::transfer        {"from":"lpc","to":"bob","quantity":"25.0000 LPC","memo":"m"}
#         lpc <= lpc.token::transfer        {"from":"lpc","to":"bob","quantity":"25.0000 LPC","memo":"m"}
#           bob <= lpc.token::transfer        {"from":"lpc","to":"bob","quantity":"25.0000 LPC","memo":"m"}
warning: transaction executed locally, but may not be confirmed by the network yet         ]
```
Now check if "bob" got the tokens using `leopays-cli get currency balance`

```shell
leopays-cli get currency balance lpc.token bob LPC
```

Result:
```text
25.00 LPC
```

Check "lpc's" balance, notice that tokens were deducted from the account 

```shell
leopays-cli get currency balance lpc.token lpc LPC
```

Result:
```text
75.00 LPC
```
