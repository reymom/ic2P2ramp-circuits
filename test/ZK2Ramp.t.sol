// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import { Test, console } from "forge-std/Test.sol";
import { Vm } from "forge-std/Vm.sol";
import { ZK2Ramp } from "../src/ZK2Ramp.sol";
import { USDT } from "../src/USDT.sol";

contract ZK2RampTest is Test {
    ZK2Ramp zk2ramp;
    USDT usdt;

    address deployer = address(0x123);
    address offramper = address(0x456);
    address onramper = address(0x789);

    function setUp() public {
        vm.startPrank(deployer);
        usdt = new USDT(deployer);
        zk2ramp = new ZK2Ramp(deployer);
        vm.stopPrank();
    }

    function testDeposit() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        assertEq(zk2ramp.getDeposit(deployer, address(usdt)), 1e18);
        vm.stopPrank();
    }

    function testWithdraw() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        zk2ramp.withdraw(address(usdt), 5e17);
        assertEq(zk2ramp.getDeposit(deployer, address(usdt)), 5e17);
        vm.stopPrank();
    }

    function testCommitDeposit() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        zk2ramp.commitDeposit(deployer, address(usdt), 5e17);
        assertEq(zk2ramp.getDeposit(deployer, address(usdt)), 5e17);
        vm.stopPrank();
    }

    function testUncommitDeposit() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        zk2ramp.commitDeposit(deployer, address(usdt), 5e17);
        zk2ramp.uncommitDeposit(deployer, address(usdt), 5e17);
        assertEq(zk2ramp.getDeposit(deployer, address(usdt)), 1e18);
        vm.stopPrank();
    }

    function testReleaseFunds() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        zk2ramp.releaseFunds(onramper, address(usdt), 1e18);
        assertEq(usdt.balanceOf(onramper), 1e18);
        vm.stopPrank();
    }

    function testDepositInsufficientFunds() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e17); // Set allowance lower than the deposit amount
        vm.expectRevert();
        zk2ramp.deposit(address(usdt), 1e18);
        vm.stopPrank();
    }

    function testWithdrawInsufficientFunds() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        vm.expectRevert();
        zk2ramp.withdraw(address(usdt), 2e18);
        vm.stopPrank();
    }

    function testCommitDepositInsufficientEscrow() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        vm.expectRevert("Insufficient escrowed funds");
        zk2ramp.commitDeposit(deployer, address(usdt), 2e18);
        vm.stopPrank();
    }

    function testUncommitDepositInsufficientEscrow() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        zk2ramp.commitDeposit(deployer, address(usdt), 5e17);
        vm.expectRevert();
        zk2ramp.uncommitDeposit(deployer, address(usdt), 2e18);
        vm.stopPrank();
    }

    function testReleaseFundsZeroAddress() public {
        vm.startPrank(deployer);
        usdt.mint(deployer, 1e18);
        usdt.approve(address(zk2ramp), 1e18);
        zk2ramp.deposit(address(usdt), 1e18);
        vm.expectRevert("Zero address onramper");
        zk2ramp.releaseFunds(address(0), address(usdt), 1e18);
        vm.stopPrank();
    }

    function testDepositZeroAddressToken() public {
        vm.startPrank(deployer);
        vm.expectRevert("Zero address token");
        zk2ramp.deposit(address(0), 1e18);
        vm.stopPrank();
    }

    function testWithdrawZeroAddressToken() public {
        vm.startPrank(deployer);
        vm.expectRevert("Zero address token");
        zk2ramp.withdraw(address(0), 1e18);
        vm.stopPrank();
    }
}
