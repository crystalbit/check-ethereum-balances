object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      // mstore(64, memoryguard(128))
      let selector := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)

      switch selector
        case 0xeb340184 /* detectBalance(address[]) */ {
          let offset := calldataload(4)

          offset := add(4, offset)
          let length := calldataload(offset)
          let arrayPos := add(offset, 0x20)

          let returnal := 0

          let end := add(arrayPos, shl(5, length))
          for { } 1 { } {
            if iszero(iszero(balance(calldataload(arrayPos))))
            {
              returnal := 1
              break
            }
            arrayPos := add(arrayPos, 0x20)
            if iszero(lt(arrayPos, end)) { break }
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

// 607961000e60003960796000f3fe7c0100000000000000000000000000000000000000000000000000000000600035048063eb340184810360765760043580600401905080356020820160008260051b82015b60011560665782353115605957600191506066565b6020830192508083106044575b6040516020810183825281810382f35b5050