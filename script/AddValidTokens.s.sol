// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/IcRamp.sol";

contract AddValidTokensScript is Script {
    address public contractAddress;
    address[] public tokenAddresses;

    function setUp() public {
        contractAddress = vm.envAddress("CONTRACT_ADDRESS");

        string memory tokenAddressesStr = vm.envString("TOKEN_ADDRESSES");

        tokenAddresses = splitStringToAddresses(tokenAddressesStr, ",");

        for (uint i = 0; i < tokenAddresses.length; i++) {
            console.log("Parsed Address: ", tokenAddresses[i]);
        }
    }

    function splitStringToAddresses(
        string memory str,
        string memory delim
    ) internal pure returns (address[] memory) {
        uint count = 1;
        for (uint i = 0; i < bytes(str).length; i++) {
            if (bytes(str)[i] == bytes(delim)[0]) {
                count++;
            }
        }

        address[] memory addresses = new address[](count);
        uint partIndex = 0;
        bytes memory currentPart = "";

        for (uint i = 0; i < bytes(str).length; i++) {
            if (bytes(str)[i] == bytes(delim)[0]) {
                addresses[partIndex] = parseAddress(string(currentPart));
                partIndex++;
                currentPart = "";
            } else {
                currentPart = abi.encodePacked(
                    currentPart,
                    bytes1(bytes(str)[i])
                );
            }
        }

        // Add the last part
        addresses[partIndex] = parseAddress(string(currentPart));

        return addresses;
    }

    function parseAddress(string memory _a) internal pure returns (address) {
        bytes memory tmp = bytes(_a);
        require(tmp.length == 42, "Invalid address length");
        uint160 addr = 0;
        for (uint i = 2; i < 42; i++) {
            uint160 b = uint160(uint8(tmp[i]));
            if ((b >= 48) && (b <= 57)) {
                addr = addr * 16 + (b - 48);
            } else if ((b >= 97) && (b <= 102)) {
                addr = addr * 16 + (b - 87);
            } else if ((b >= 65) && (b <= 70)) {
                addr = addr * 16 + (b - 55);
            }
        }
        return address(addr);
    }

    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);

        IcRamp contractInstance = IcRamp(contractAddress);
        contractInstance.addValidTokens(tokenAddresses);

        vm.stopBroadcast();
    }
}
