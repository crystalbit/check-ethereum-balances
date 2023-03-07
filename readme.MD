Contracts are written both in solidity and yul.

To test both versions:  
`forge test --ffi`  

Compile yul version:  
`solc --strict-assembly yul/BalanceViewer.yul`  

Gas report:  
`forge snapshot --ffi && cat .gas-snapshot`  
