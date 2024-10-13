#!/bin/bash

source .env
echo "Running deploy script"
forge script script/Deploy.s.sol:Deploy \
 --ffi \
 --rpc-url $ARBITRUM_SEPOLIA_RPC_URL \
 --etherscan-api-key $ARBISCAN_API_KEY \
 --chain-id 421614 \
 --slow \
 --broadcast \
 --verify \
 -vvvv