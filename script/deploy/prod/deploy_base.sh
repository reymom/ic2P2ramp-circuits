#!/bin/bash

source .env.prod
echo "Running deploy script"
OWNER=${OWNER} PRIVATE_KEY=${PRIVATE_KEY} forge script script/Deploy.s.sol:Deploy \
    --ffi --rpc-url $BASE_RPC_URL --etherscan-api-key ${BASESCAN_API_KEY} \
    --slow --broadcast --verify -vvvv --via-ir