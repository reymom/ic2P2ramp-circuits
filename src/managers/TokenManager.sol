// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ITokenManager} from "../model/Interfaces.sol";
import {Errors} from "../model/Errors.sol";

contract TokenManager is Ownable, ITokenManager {
    mapping(address => bool) private validTokens;

    event TokenAdded(address indexed token);
    event TokenRemoved(address indexed token);

    constructor(address _owner) Ownable(_owner) {}

    /********
     * VIEW *
     ********/

    function isValidToken(address _token) external view returns (bool) {
        return validTokens[_token];
    }

    /*********
     * WRITE *
     *********/

    function addValidTokens(address[] memory _tokens) external onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            address token = _tokens[i];
            if (token == address(0)) revert Errors.ZeroAddress();
            validTokens[token] = true;
            emit TokenAdded(token);
        }
    }

    function removeValidTokens(address[] memory _tokens) external onlyOwner {
        for (uint256 i = 0; i < _tokens.length; i++) {
            address token = _tokens[i];
            if (token == address(0)) revert Errors.ZeroAddress();
            validTokens[token] = false;
            emit TokenRemoved(token);
        }
    }
}
