// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {IcRamp} from "../src/IcRamp.sol";

contract Deploy is Script {
    function run() external {
        address owner = vm.envAddress("OWNER");
        console.log("Owner:", owner);
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        IcRamp icRamp = new IcRamp(owner);
        console.log("IcRamp deployed at:", address(icRamp));

        vm.stopBroadcast();
    }
}
