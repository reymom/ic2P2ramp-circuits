#!/bin/bash

source .env.prod
echo "Running deploy script"
OWNER=${OWNER} PRIVATE_KEY=${PRIVATE_KEY} forge script script/Deploy.s.sol:Deploy \
 --ffi \
 --rpc-url $ARBITRUM_RPC_URL \
 --etherscan-api-key $ARBISCAN_API_KEY \
 --chain-id 42161 \
 --slow \
 --broadcast \
 --verify \
 -vvvv