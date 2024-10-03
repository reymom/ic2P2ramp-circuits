#!/bin/bash

ROOT_DIR="$(dirname "$0")/../.."  # Navigate to the root directory
export $(cat "$ROOT_DIR/.env" | xargs)

# forge script script/TransferEth.s.sol:SendFundsToIcpEvmCanister --fork-url ${SEPOLIA_RPC_URL} --broadcast
# forge script script/TransferEth.s.sol:SendFundsToIcpEvmCanister --fork-url ${BASE_SEPOLIA_RPC_URL} --broadcast
# forge script script/TransferEth.s.sol:SendFundsToIcpEvmCanister --fork-url ${OP_SEPOLIA_RPC_URL} --broadcast
forge script script/TransferEth.s.sol:SendFundsToIcpEvmCanister --fork-url ${MANTLE_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${ETHERSCAN_API_KEY} --gas-limit 100000000000 --gas-price 20000000 --skip-simulation