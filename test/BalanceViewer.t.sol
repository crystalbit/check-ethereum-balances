// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BalanceViewer.sol";

contract BalanceViewerTest is Test {
    BalanceViewer public balanceViewer;

    function setUp() public {
        balanceViewer = new BalanceViewer();
    }

    function testNoBalance() public {
        address[] memory addresses = new address[](3);
        addresses[0] = address(3);
        addresses[1] = address(4);
        addresses[2] = address(5);
        assertEq(balanceViewer.detectBalance(addresses), 0);
        vm.deal(address(5), 1 ether);
        assertEq(balanceViewer.detectBalance(addresses), 1);
    }
}
