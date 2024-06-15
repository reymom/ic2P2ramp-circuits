// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;

interface IEscrowManager {
    function getDeposit(address _offramper, address _token) external view returns (uint256);
    function deposit(address _offramper, address _token, uint256 _amount) external;
    function withdraw(address _offramper, address _token, uint256 _amount) external;
    function commitDeposit(address _offramper, address _token, uint256 _amount) external;
    function uncommitDeposit(address _offramper, address _token, uint256 _amount) external;
    function releaseCommittedFunds(address _offramper, address _token, uint256 _amount) external;
}

interface ITokenManager {
    function addValidTokens(address[] memory _tokens) external;
    function removeValidTokens(address[] memory _tokens) external;
    function isValidToken(address _token) external view returns (bool); 
}

interface IRamp {
    function tokenManager() external view returns (ITokenManager);
    function escrowManager() external view returns (IEscrowManager);

    function setIcpEvmCanister(address _icpBackend) external;
    function getDeposit(address _user, address _token) external view returns (uint256);
    function depositToken(address _token, uint256 _amount) external;
    function depositBaseCurrency() external payable;
    function withdrawToken(address _token, uint256 _amount) external;
    function withdrawBaseCurrency(uint256 _amount) external;
    function commitDeposit(address _offramper, address _token, uint256 _amount) external;
    function uncommitDeposit(address _offramper, address _token, uint256 _amount) external;
    function releaseFunds(address _offramper, address _onramper, address _token, uint256 _amount) external;
    function releaseBaseCurrency(address _offramper, address _onramper, uint256 _amount) external;
    function addValidTokens(address[] memory _tokens) external;
    function removeValidTokens(address[] memory _tokens) external;
}