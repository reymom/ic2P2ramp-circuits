// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract SendFundsToIcpEvmCanister is Script {
    address icpEvmCanisterAddress = vm.envAddress("ICP_EVM_CANISTER_ADDRESS");
    uint256 amountToSend = vm.envUint("AMOUNT_TO_SEND"); // wei

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        payable(icpEvmCanisterAddress).transfer(amountToSend);

        vm.stopBroadcast();
    }

    receive() external payable {}
}
