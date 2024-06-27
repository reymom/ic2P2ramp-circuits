#!/bin/bash

source .env
echo "Running deploy script"
forge script script/Deploy.s.sol:Deploy --ffi --rpc-url $POLYGON_RPC_URL --legacy --slow --broadcast
