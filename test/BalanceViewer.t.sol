// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BalanceViewer.sol";
import "./lib/YulDeployer.sol";
import "forge-std/console.sol";

contract BalanceViewerTest is Test {
    YulDeployer yulDeployer = new YulDeployer();
    BalanceViewer public balanceViewer;
    address public yulBalanceViewer;

    function setUp() public {
        balanceViewer = new BalanceViewer();
        yulBalanceViewer = yulDeployer.deployContract("BalanceViewer");
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
        yulBalanceViewer.staticcall(abi.encode(address(3), address(4), address(5)));
    }

    function testYul() public {
        address address0 = address(3);
        address address1 = address(4);
        address address2 = address(5);
        (bool success, bytes memory result) = yulBalanceViewer.staticcall(abi.encode(address0, address1, address2));
        assertEq(uint256(bytes32(result)), 0);
        assertTrue(success);
        vm.deal(address(5), 1 ether);
        (success, result) = yulBalanceViewer.staticcall(abi.encode(address0, address1, address2));
        assertEq(uint256(bytes32(result)), 1);
        assertTrue(success);
    }
}
