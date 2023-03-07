// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BalanceViewer.sol";
import "./lib/YulDeployer.sol";

contract BalanceViewerTest is Test {
    YulDeployer yulDeployer = new YulDeployer();
    BalanceViewer public balanceViewer;
    BalanceViewer public yulBalanceViewer;

    function setUp() public {
        balanceViewer = new BalanceViewer();
        yulBalanceViewer = BalanceViewer(yulDeployer.deployContract("BalanceViewer"));
    }

    function testSolidity() public {
        address[] memory addresses = new address[](3);
        addresses[0] = address(3);
        addresses[1] = address(4);
        addresses[2] = address(5);
        assertEq(balanceViewer.detectBalance(addresses), 0);
        vm.deal(address(5), 1 ether);
        assertEq(balanceViewer.detectBalance(addresses), 1);
    }

    function testGasSnapshot() external view {
        yulBalanceViewer.detectBalance(new address[](3));
    }

    function testYul() public {
        address[] memory addresses = new address[](3);
        addresses[0] = address(3);
        addresses[1] = address(4);
        addresses[2] = address(5);
        assertEq(yulBalanceViewer.detectBalance(addresses), 0);
        vm.deal(address(5), 1 ether);
        assertEq(yulBalanceViewer.detectBalance(addresses), 1);
    }
}
