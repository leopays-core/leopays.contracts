## How to build the LeoPays.Contracts

### Preconditions
Ensure an appropriate version of `LeoPays.CDT` is installed. Installing `LeoPays.CDT` from binaries is sufficient, follow the [`LeoPays.CDT` installation instructions steps](https://github.com/leopays-core/leopays.cdt/tree/master/#binary-releases) to install it. To verify if you have `LeoPays.CDT` installed and its version run the following command 

```sh
leopays-cpp -v
```

#### Build contracts using the build script

##### To build contracts alone
Run the `build.sh` script in the top directory to build all the contracts.

##### To build the contracts and unit tests
1. Ensure an appropriate version of `LeoPays` has been built from source and installed. Installing `LeoPays` from binaries `is not` sufficient. You can find instructions on how to do it [here](https://github.com/leopays-core/leopays/blob/master/README.md) in section `Building from Sources`.
2. Run the `build.sh` script in the top directory with the `-t` flag to build all the contracts and the unit tests for these contracts.

#### Build contracts manually

To build the `LeoPays.Contracts` execute the following commands.

On all platforms except macOS:
```sh
cd you_local_path_to/leopays.contracts/
rm -fr build
mkdir build
cd build
cmake ..
make -j$( nproc )
cd ..
```

For macOS:
```sh
cd you_local_path_to/leopays.contracts/
rm -fr build
mkdir build
cd build
cmake ..
make -j$(sysctl -n hw.ncpu)
cd ..
```

#### After build:
* If the build was configured to also build unit tests, the unit tests executable is placed in the _build/tests_ folder and is named __unit_test__.
* The contracts (both `.wasm` and `.abi` files) are built into their corresponding _build/contracts/\<contract name\>_ folder.
* Finally, simply use __leopays-cli__ to _set contract_ by pointing to the previously mentioned directory for the specific contract.

## How to deploy the LeoPays.Contracts

### To deploy eosio.bios contract execute the following command:
Let's assume your account name to which you want to deploy the contract is `testerbios`
```
leopays-cli set contract testerbios you_local_path_to/leopays.contracts/build/contracts/eosio.bios/ -p testerbios
```

### To deploy eosio.msig contract execute the following command:
Let's assume your account name to which you want to deploy the contract is `testermsig`
```
leopays-cli set contract testermsig you_local_path_to/leopays.contracts/build/contracts/eosio.msig/ -p testermsig
```

### To deploy eosio.system contract execute the following command:
Let's assume your account name to which you want to deploy the contract is `testersystem`
```
leopays-cli set contract testersystem you_local_path_to/leopays.contracts/build/contracts/eosio.system/ -p testersystem
```

### To deploy eosio.token contract execute the following command:
Let's assume your account name to which you want to deploy the contract is `testertoken`
```
leopays-cli set contract testertoken you_local_path_to/leopays.contracts/build/contracts/eosio.token/ -p testertoken
```

### To deploy eosio.wrap contract execute the following command:
Let's assume your account name to which you want to deploy the contract is `testerwrap`
```
leopays-cli set contract testerwrap you_local_path_to/leopays.contracts/build/contracts/eosio.wrap/ -p testerwrap
```