object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      mstore(64, memoryguard(128))
      let selector := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)

      switch selector
        case 0xeb340184 /* detectBalance(address[]) */ {
          let offset := calldataload(4)

          offset := add(4, offset)
          let length := calldataload(offset)
          let arrayPos := add(offset, 0x20)

          let returnal := 0

          let end := add(arrayPos, shl(5, length))
          let i := arrayPos
          for { } 1 { } {
            if iszero(iszero(balance(calldataload(i))))
            {
              returnal := 1
              break
            }
            i := add(i, 0x20)
            if iszero(lt(i, end)) { break }
          }
          let memPos := mload(64)
          let memEnd := add(memPos, 32)

          mstore(memPos, returnal)
          return(memPos, sub(memEnd, memPos))
        }
        default { }
    }
  }
}
