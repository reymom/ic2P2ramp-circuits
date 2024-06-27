# ic2p2Ramp Contracts

This repository contains escrow management contracts for an onramping protocol integrated with the Internet Computer (ICP). The contracts manage deposits and withdrawals of ERC20 tokens, allowing different offrampers to commit and release funds in a decentralized and privacy-preserving manner.

## Deployments

| Network                | Contract Name | Address                                    |
| ---------------------- | ------------- | ------------------------------------------ |
| Mantle Sepolia Testnet | Ic2P2Ramp     | 0xdB976eCC0c95Ea84d7bB7249920Fcc73392783F5 |
| Sepolia                | Ic2P2Ramp     | 0x42ad57ab757ea55960f7d9805d82fa818683096b |
| Sepolia BaseScan       | Ic2P2Ramp     | 0xfa29381958DD8a2dD86246FC0Ab2932972640580 |
| Optimism Testnet       | Ic2P2Ramp     | 0x9025e74D23384f664CfEB07F1d8ABd19570758B5 |
| Polygon zkEVM Testnet  | Ic2P2Ramp     | 0x9025e74D23384f664CfEB07F1d8ABd19570758B5 |

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
