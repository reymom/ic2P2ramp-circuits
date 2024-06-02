// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { ZK2Ramp } from "../src/ZK2Ramp.sol";
import { USDT } from "../src/USDT.sol";

contract Deploy is Script {
    function run() external {
        address owner = vm.envAddress("OWNER");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy USDT token
        USDT usdt = new USDT(owner);
        console.log("USDT deployed at:", address(usdt));

        // Deploy ZK2Ramp
        ZK2Ramp zk2Ramp = new ZK2Ramp(owner);
        console.log("ZK2Ramp deployed at:", address(zk2Ramp));

        vm.stopBroadcast();
    }
}
