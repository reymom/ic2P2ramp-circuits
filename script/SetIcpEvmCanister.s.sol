// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Ic2P2ramp.sol";

contract SetIcpEvmCanisterScript is Script {
    address icpEvmCanisterAddress = vm.envAddress("ICP_EVM_CANISTER_ADDRESS");
    address contractAddress = vm.envAddress("CONTRACT_ADDRESS");

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Ic2P2ramp icP2Pramp = Ic2P2ramp(contractAddress);
        icP2Pramp.setIcpEvmCanister(icpEvmCanisterAddress);

        vm.stopBroadcast();
    }
}
