#!/bin/bash

ROOT_DIR="$(dirname "$0")/.."  # Navigate to the root directory
export $(cat "$ROOT_DIR/.env" | xargs)

export CONTRACT_ADDRESS=${CONTRACT_SEPOLIA}
export TOKEN_ADDRESSES="0x878bfCfbB8EAFA8A2189fd616F282E1637E06bcF"
forge script script/AddValidTokens.s.sol:AddValidTokensScript --rpc-url ${SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${ETHERSCAN_API_KEY}

export CONTRACT_ADDRESS=${CONTRACT_BASE_SEPOLIA}
export TOKEN_ADDRESSES="0x036CbD53842c5426634e7929541eC2318f3dCF7e"
forge script script/AddValidTokens.s.sol:AddValidTokensScript --rpc-url ${BASE_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${BASESCAN_API_KEY}

# export CONTRACT_ADDRESS=${CONTRACT_OP_SEPOLIA}
# export TOKEN_ADDRESSES="0xAddress1,0xAddress2"
# forge script script/AddValidTokens.s.sol:AddValidTokensScript --rpc-url ${OP_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${OP_ETHERSCAN_API_KEY}

# export CONTRACT_ADDRESS=${CONTRACT_MANTLE_SEPOLIA}
# export TOKEN_ADDRESSES="0xAddress1,0xAddress2"
# forge script script/AddValidTokens.s.sol:AddValidTokensScript --rpc-url ${MANTLE_SEPOLIA_RPC_URL} --broadcast --etherscan-api-key ${ETHERSCAN_API_KEY}
