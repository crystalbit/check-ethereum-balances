// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract BalanceViewer {
    function detectBalance(address[] calldata addresses) external view returns (uint256 result) {
        assembly {
            let end := add(addresses.offset, shl(5, addresses.length))
            let i := addresses.offset
            for {} 1 {} {
                if iszero(iszero(balance(calldataload(i)))) {
                    result := 1
                    break
                }
                i := add(i, 0x20)
                if iszero(lt(i, end)) { break }
            }
        }
    }
}
