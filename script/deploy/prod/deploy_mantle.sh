#!/bin/bash

source .env
echo "Running deploy script"

forge script script/Deploy.s.sol:Deploy --rpc-url $MANTLE_SEPOLIA_RPC_URL --skip-simulation --slow --broadcast --verify --verifier blockscout --verifier-url "https://explorer.sepolia.mantle.xyz/api?module=contract&action=verify" -vvvv --via-ir