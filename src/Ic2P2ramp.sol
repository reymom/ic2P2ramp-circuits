// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IEscrowManager, ITokenManager, IRamp} from "./model/Interfaces.sol";
import {TokenManager} from "./managers/TokenManager.sol";
import {EscrowManager} from "./managers/EscrowManager.sol";
import {Errors} from "./model/Errors.sol";

contract Ic2P2ramp is Ownable, ReentrancyGuard, IRamp {
    using SafeERC20 for IERC20;

    IEscrowManager public immutable escrowManager;
    ITokenManager public immutable tokenManager;
    address public icpEvmCanister;

    constructor(address _owner) Ownable(_owner) {
        escrowManager = new EscrowManager(address(this));
        tokenManager = new TokenManager(address(this));
        icpEvmCanister = _owner;
    }

    modifier onlyIcpEvmCanister() {
        if (msg.sender != icpEvmCanister) revert Errors.Unauthorized();
        _;
    }

    function setIcpEvmCanister(address _icpEvmCanister) external onlyOwner {
        icpEvmCanister = _icpEvmCanister;
    }

    /*
     * VIEW FUNCTIONS
     */

    function getDeposit(
        address _user,
        address _token
    ) external view returns (uint256) {
        return escrowManager.getDeposit(_user, _token);
    }

    function isValidToken(address _token) external view returns (bool) {
        return tokenManager.isValidToken(_token);
    }

    /*
     * OFFRAMPER
     */

    function depositToken(
        address _token,
        uint256 _amount
    ) external nonReentrant {
        if (_token == address(0)) revert Errors.ZeroAddress();
        if (!tokenManager.isValidToken(_token))
            revert Errors.TokenNotAccepted();

        escrowManager.deposit(msg.sender, _token, _amount);
        IERC20(_token).safeTransferFrom(msg.sender, address(this), _amount);
    }

    function depositBaseCurrency() external payable nonReentrant {
        escrowManager.deposit(msg.sender, address(0), msg.value);
    }

    function withdrawToken(
        address _token,
        uint256 _amount
    ) external nonReentrant {
        if (_token == address(0)) revert Errors.ZeroAddress();
        if (!tokenManager.isValidToken(_token))
            revert Errors.TokenNotAccepted();

        escrowManager.withdraw(msg.sender, _token, _amount);
        IERC20(_token).safeTransfer(msg.sender, _amount);
    }

    function withdrawBaseCurrency(uint256 _amount) external nonReentrant {
        escrowManager.withdraw(msg.sender, address(0), _amount);
        payable(msg.sender).transfer(_amount);
    }

    function commitDeposit(
        address _offramper,
        address _token,
        uint256 _amount
    ) external nonReentrant onlyIcpEvmCanister {
        escrowManager.commitDeposit(_offramper, _token, _amount);
    }

    function uncommitDeposit(
        address _offramper,
        address _token,
        uint256 _amount
    ) external nonReentrant onlyIcpEvmCanister {
        escrowManager.uncommitDeposit(_offramper, _token, _amount);
    }

    /*
     * ONRAMPER
     */

    function releaseFunds(
        address _offramper,
        address _onramper,
        address _token,
        uint256 _amount
    ) external nonReentrant onlyIcpEvmCanister {
        if (_onramper == address(0)) revert Errors.ZeroAddress();
        if (_token == address(0)) revert Errors.ZeroAddress();

        escrowManager.releaseCommittedFunds(_offramper, _token, _amount);
        IERC20(_token).safeTransfer(_onramper, _amount);
    }

    function releaseBaseCurrency(
        address _offramper,
        address _onramper,
        uint256 _amount
    ) external nonReentrant onlyIcpEvmCanister {
        if (_onramper == address(0)) revert Errors.ZeroAddress();

        escrowManager.releaseCommittedFunds(_offramper, address(0), _amount);
        payable(_onramper).transfer(_amount);
    }

    /*
     * TOKENS
     */

    function addValidTokens(address[] memory _tokens) external onlyOwner {
        tokenManager.addValidTokens(_tokens);
    }

    function removeValidTokens(address[] memory _tokens) external onlyOwner {
        tokenManager.removeValidTokens(_tokens);
    }
}
