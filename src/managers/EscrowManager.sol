// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IEscrowManager} from "../model/Interfaces.sol";
import {Errors} from "../model/Errors.sol";

contract EscrowManager is Ownable, ReentrancyGuard, IEscrowManager {
    // offramper => token => deposit amount
    mapping(address => mapping(address => uint256)) private deposits;
    // offramper => token => committed amount
    mapping(address => mapping(address => uint256)) private committed;

    constructor(address _owner) Ownable(_owner) {}

    event FeeTracked(address indexed user, address indexed token, uint256 fees);
    event Deposit(address indexed user, address indexed token, uint256 amount);
    event Withdraw(address indexed user, address indexed token, uint256 amount);
    event DepositCommitted(
        address indexed user,
        address indexed token,
        uint256 amount
    );
    event DepositUncommitted(
        address indexed user,
        address indexed token,
        uint256 amount
    );

    /********
     * VIEW *
     ********/

    function getDeposit(
        address _offramper,
        address _token
    ) external view returns (uint256) {
        return deposits[_offramper][_token];
    }

    /*********
     * WRITE *
     *********/

    function deposit(
        address _offramper,
        address _token,
        uint256 _amount
    ) external nonReentrant onlyOwner {
        if (_offramper == address(0)) revert Errors.ZeroAddress();
        if (_amount <= 0) revert Errors.ZeroAmount();

        deposits[_offramper][_token] += _amount;
        emit Deposit(_offramper, _token, _amount);
    }

    function withdraw(
        address _offramper,
        address _token,
        uint256 _amount
    ) external nonReentrant onlyOwner {
        if (_offramper == address(0)) revert Errors.ZeroAddress();
        if (_amount <= 0) revert Errors.ZeroAmount();
        if (deposits[_offramper][_token] < _amount)
            revert Errors.InsufficientFunds();

        deposits[_offramper][_token] -= _amount;
        emit Withdraw(_offramper, _token, _amount);
    }

    function commitDeposit(
        address _offramper,
        address _token,
        uint256 _amount
    ) external onlyOwner {
        if (_offramper == address(0)) revert Errors.ZeroAddress();
        if (_amount <= 0) revert Errors.ZeroAmount();
        if (deposits[_offramper][_token] < _amount)
            revert Errors.InsufficientFunds();

        deposits[_offramper][_token] -= _amount;
        committed[_offramper][_token] += _amount;
        emit DepositCommitted(_offramper, _token, _amount);
    }

    function uncommitDeposit(
        address _offramper,
        address _token,
        uint256 _amount
    ) external onlyOwner {
        if (_offramper == address(0)) revert Errors.ZeroAddress();
        if (_amount <= 0) revert Errors.ZeroAmount();
        if (committed[_offramper][_token] < _amount)
            revert Errors.InsufficientFunds();

        committed[_offramper][_token] -= _amount;
        deposits[_offramper][_token] += _amount;
        emit DepositUncommitted(_offramper, _token, _amount);
    }

    function releaseCommittedFunds(
        address _offramper,
        address _token,
        uint256 _amount
    ) external onlyOwner {
        if (_offramper == address(0)) revert Errors.ZeroAddress();
        if (_amount <= 0) revert Errors.ZeroAmount();
        if (committed[_offramper][_token] < _amount)
            revert Errors.InsufficientFunds();

        committed[_offramper][_token] -= _amount;
    }

    function trackFees(
        address _receiver,
        address _token,
        uint256 _fees
    ) external nonReentrant onlyOwner {
        deposits[_receiver][_token] += _fees;
        emit FeeTracked(_receiver, _token, _fees);
    }
}
