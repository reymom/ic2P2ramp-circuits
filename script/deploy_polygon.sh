#!/bin/bash

source .env
echo "Running deploy script"
forge script script/Deploy.s.sol:Deploy --ffi --rpc-url $POLYGON_RPC_URL --etherscan-api-key ${ETHERSCAN_API_KEY}  --slow --broadcast --verify -vvvv --via-ir --legacy
