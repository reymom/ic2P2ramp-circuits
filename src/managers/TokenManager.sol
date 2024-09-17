// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ITokenManager} from "../model/Interfaces.sol";
import {Errors} from "../model/Errors.sol";

contract TokenManager is Ownable, ITokenManager {
    mapping(address => bool) private validTokens;
    address[] private tokenList;

    event TokenAdded(address indexed token);
    event TokenRemoved(address indexed token);

    constructor(address _owner) Ownable(_owner) {}

    /********
     * VIEW *
     ********/

    function isValidToken(address _token) external view returns (bool) {
        return validTokens[_token];
    }

    function getValidTokens() external view returns (address[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < tokenList.length; i++) {
            if (validTokens[tokenList[i]]) {
                count++;
            }
        }

        address[] memory validTokenArray = new address[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < tokenList.length; i++) {
            if (validTokens[tokenList[i]]) {
                validTokenArray[index] = tokenList[i];
                index++;
            }
        }

        return validTokenArray;
    }

    /*********
     * WRITE *
     *********/

    function addValidTokens(address[] memory _tokens) external onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            address token = _tokens[i];
            if (token == address(0)) revert Errors.ZeroAddress();
            if (!validTokens[token]) {
                validTokens[token] = true;
                tokenList.push(token);
                emit TokenAdded(token);
            }
        }
    }

    function removeValidTokens(address[] memory _tokens) external onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            address token = _tokens[i];
            if (token == address(0)) revert Errors.ZeroAddress();
            if (validTokens[token]) {
                validTokens[token] = false;
                _removeTokenFromArray(token);
                emit TokenRemoved(token);
            }
        }
    }

    function _removeTokenFromArray(address _token) internal {
        for (uint256 i = 0; i < tokenList.length; i++) {
            if (tokenList[i] == _token) {
                tokenList[i] = tokenList[tokenList.length - 1];
                tokenList.pop();
                break;
            }
        }
    }
}
