#!/bin/bash

source .env.prod
echo "Running deploy script"
OWNER=${OWNER} PRIVATE_KEY=${PRIVATE_KEY} forge script script/Deploy.s.sol:Deploy \ 
    --ffi --rpc-url $MAINNET_RPC_URL --etherscan-api-key ${ETHERSCAN_API_KEY} \
    --slow --broadcast --verify -vvvv --via-ir