# ic2p2Ramp Contracts

This repository contains escrow management contracts for an onramping protocol integrated with the Internet Computer (ICP). The contracts manage deposits and withdrawals of ERC20 tokens, allowing different offrampers to commit and release funds in a decentralized and privacy-preserving manner.

## Deployments

### In Mantle Sepolia Testnet

- ic2p2Ramp: 0x8B1b90637F188541401DeeA100718ca618927E52
- USDT: 0x67d2d3a45457b69259FB1F8d8178bAE4F6B11b4d

## In Sepolia

- ic2p2Ramp: 0xdaE80C0f07Bc847840f7342a8EC9AD78e695c5a3
- USDT: 0x878bfCfbB8EAFA8A2189fd616F282E1637E06bcF

## In Optimism Testnet

- ic2p2Ramp:

## In Polygon zkEVM Testnet

- ic2p2Ramp:

## Contract Details

### ic2p2Ramp Contract

The `ic2p2Ramp` contract is designed to handle deposits and withdrawals of ERC20 tokens with escrow functionality. Offrampers can commit deposits, and the owner (or an authorized entity) can release funds to onrampers.

#### Functions

- `deposit(address \_token, uint256 \_amount)`: Allows a user to deposit a specified amount of an ERC20 token into the contract.
- `withdraw(address \_token, uint256 \_amount)`: Allows a user to withdraw a specified amount of an ERC20 token from the contract.
- `commitDeposit(address \_offramper, address \_token, uint256 \_amount)`: Allows the owner to commit a deposit from an offramper.
- `uncommitDeposit(address \_offramper, address \_token, uint256 \_amount)`: Allows the owner to uncommit a previously committed deposit.
- `releaseFunds(address \_onramper, address \_token, uint256 \_amount)`: Allows the owner to release funds to an onramper. Note: The onlyOwner modifier has been removed from this function to allow the canister to call it.

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
