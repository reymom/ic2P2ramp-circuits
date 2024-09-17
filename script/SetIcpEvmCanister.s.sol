// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/IcRamp.sol";

contract SetIcpEvmCanisterScript is Script {
    address icpEvmCanisterAddress = vm.envAddress("ICP_EVM_CANISTER_ADDRESS");
    address contractAddress = vm.envAddress("CONTRACT_ADDRESS");

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        IcRamp icRamp = IcRamp(contractAddress);
        icRamp.setIcpEvmCanister(icpEvmCanisterAddress);

        vm.stopBroadcast();
    }
}
