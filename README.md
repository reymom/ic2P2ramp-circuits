# ic2p2Ramp Contracts

This repository contains escrow management contracts for an onramping protocol integrated with the Internet Computer (ICP). The contracts manage deposits and withdrawals of ERC20 tokens, allowing different offrampers to commit and release funds in a decentralized and privacy-preserving manner.

## Deployments

| Network                | Contract Name | Address                                    |
| ---------------------- | ------------- | ------------------------------------------ |
| Sepolia                | Ic2P2Ramp     | 0x4Dfe1aAf305Bfc857529d26053a9E18f87Bfc7d6 |
| Base Sepolia           | Ic2P2Ramp     | 0x43550deEd0bC15a1e7918862558d8E46477536bA |
| Optimism Sepolia       | Ic2P2Ramp     | 0x602475c17c020fe3af7294ec4acf68f93198332c |
| Mantle Sepolia Testnet | Ic2P2Ramp     | 0x43550deEd0bC15a1e7918862558d8E46477536bA |

## Contract Details

### ic2p2Ramp Contract

The `ic2p2Ramp` contract is designed to handle deposits and withdrawals of ERC20 tokens with escrow functionality. Offrampers can commit deposits, and the owner (or an authorized entity) can release funds to onrampers.

#### Functions

- `deposit(address _token, uint256 _amount)`: Allows a user to deposit a specified amount of an ERC20 token into the contract.
- `withdraw(address _token, uint256 _amount)`: Allows a user to withdraw a specified amount of an ERC20 token from the contract.
- `commitDeposit(address _offramper, address _token, uint256 _amount)`: Allows the owner to commit a deposit from an offramper.
- `uncommitDeposit(address _offramper, address _token, uint256 _amount)`: Allows the owner to uncommit a previously committed deposit.
- `releaseFunds(address _onramper, address _token, uint256 _amount)`: Allows the owner to release funds to an onramper. Note: The onlyOwner modifier has been removed from this function to allow the canister to call it.

#### Events

- `Deposit(address indexed user, address indexed token, uint256 amount)`: Emitted when a user deposits tokens.
- `Withdraw(address indexed user, address indexed token, uint256 amount)`: Emitted when a user withdraws tokens.
- `DepositCommitted(address indexed user, address indexed token, uint256 amount)`: Emitted when a deposit is committed.
- `DepositUncommitted(address indexed user, address indexed token, uint256 amount)`: Emitted when a committed deposit is uncommitted.

### USDT Contract

The USDT contract is a standard ERC20 token used for testing the `ic2p2Ramp` contract. It allows minting and transferring of tokens for simulation purposes.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```
