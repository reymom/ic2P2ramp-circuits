// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Ic2P2ramp} from "../src/Ic2P2ramp.sol";

contract Deploy is Script {
    function run() external {
        address owner = vm.envAddress("OWNER");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy ZK2Ramp
        Ic2P2ramp ic2P2ramp = new Ic2P2ramp(owner);
        console.log("Ic2P2ramp deployed at:", address(ic2P2ramp));

        vm.stopBroadcast();
    }
}
