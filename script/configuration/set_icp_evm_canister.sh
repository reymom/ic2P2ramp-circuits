#!/bin/bash

ROOT_DIR="$(dirname "$0")/../.."  # Navigate to the root directory
export $(cat "$ROOT_DIR/.env" | xargs)

export CONTRACT_ADDRESS=${CONTRACT_SEPOLIA}
forge script script/SetIcpEvmCanister.s.sol:SetIcpEvmCanisterScript --rpc-url ${SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${ETHERSCAN_API_KEY}

export CONTRACT_ADDRESS=${CONTRACT_BASE_SEPOLIA}
forge script script/SetIcpEvmCanister.s.sol:SetIcpEvmCanisterScript --rpc-url ${BASE_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${BASESCAN_API_KEY}

export CONTRACT_ADDRESS=${CONTRACT_OP_SEPOLIA}
forge script script/SetIcpEvmCanister.s.sol:SetIcpEvmCanisterScript --rpc-url ${OP_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${OP_ETHERSCAN_API_KEY}

export CONTRACT_ADDRESS=${CONTRACT_MANTLE_SEPOLIA}
forge script script/SetIcpEvmCanister.s.sol:SetIcpEvmCanisterScript --rpc-url ${MANTLE_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${ETHERSCAN_API_KEY} --gas-limit 100000000000 --gas-price 20000000 --skip-simulation