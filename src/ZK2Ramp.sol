// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { ReentrancyGuard } from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract ZK2Ramp is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    event Deposit(address indexed user, address indexed token, uint256 amount);
    event Withdraw(address indexed user, address indexed token, uint256 amount);
    event DepositCommitted(address indexed user, address indexed token, uint256 amount);
    event DepositUncommitted(address indexed user, address indexed token, uint256 amount);

    // offramper => token => deposit amount
    mapping(address => mapping(address => uint256)) private deposits;

    constructor(address _owner) Ownable(_owner) {}

    /**
     * VIEW FUNCTIONS
     */
    function getDeposit(address _user, address _token) external view returns (uint256) {
        return deposits[_user][_token];
    }

    /**
     * DEPOSIT FUNCTIONS
     */
    function deposit(address _token, uint256 _amount) external nonReentrant {
        require(_token != address(0), "Zero address token");
        require(_amount > 0, "Zero amount");

        deposits[msg.sender][_token] += _amount;
        emit Deposit(msg.sender, _token, _amount);

        IERC20(_token).safeTransferFrom(msg.sender, address(this), _amount);
    }

    function depositBaseCurrency() external payable nonReentrant {
        require(msg.value > 0, "Zero amount");

        deposits[msg.sender][address(0)] += msg.value;
        emit Deposit(msg.sender, address(0), msg.value);
    }

    function withdraw(address _token, uint256 _amount) external nonReentrant {
        require(_token != address(0), "Zero address token");
        require(_amount > 0, "Zero amount");
        require(deposits[msg.sender][_token] >= _amount, "Insufficient funds");

        deposits[msg.sender][_token] -= _amount;
        emit Withdraw(msg.sender, _token, _amount);

        IERC20(_token).safeTransfer(msg.sender, _amount);
    }

    function withdrawBaseCurrency(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Zero amount");
        require(deposits[msg.sender][address(0)] >= _amount, "Insufficient funds");

        deposits[msg.sender][address(0)] -= _amount;
        emit Withdraw(msg.sender, address(0), _amount);

        payable(msg.sender).transfer(_amount);
    }

    function commitDeposit(address _offramper, address _token, uint256 _amount) external nonReentrant {
        require(_offramper != address(0), "Zero address offramper");
        require(_amount > 0, "Zero amount");
        require(deposits[_offramper][_token] >= _amount, "Insufficient escrowed funds");

        deposits[_offramper][_token] -= _amount;
        emit DepositCommitted(_offramper, _token, _amount);
    }

    function uncommitDeposit(address _offramper, address _token, uint256 _amount) external nonReentrant {
        require(_offramper != address(0), "Zero address offramper");
        require(_amount > 0, "Zero amount");
        require(deposits[_offramper][_token] >= _amount, "Insufficient escrowed funds");

        deposits[_offramper][_token] += _amount;
        emit DepositUncommitted(_offramper, _token, _amount);
    }

    function releaseFunds(address _onramper, address _token, uint256 _amount) external nonReentrant {
        require(_token != address(0), "Zero address token");
        require(_onramper != address(0), "Zero address onramper");
        require(_amount > 0, "Zero amount");

        IERC20(_token).safeTransfer(_onramper, _amount);
    }

    function releaseBaseCurrency(address _onramper, uint256 _amount) external nonReentrant {
        require(_onramper != address(0), "Zero address onramper");
        require(_amount > 0, "Zero amount");

        payable(_onramper).transfer(_amount);
    }
}
