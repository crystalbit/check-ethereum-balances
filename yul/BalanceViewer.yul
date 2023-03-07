object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      // use any selector. for example, 0xeb340184: detectBalance(address[])

      let offset := add(4, calldataload(4))
      let arrayPos := add(offset, 0x20)
      let memPos := mload(0x40)

      let end := add(arrayPos, shl(5, calldataload(offset)))
      for { } 1 { } {
        if iszero(iszero(balance(calldataload(arrayPos))))
        {
          mstore(memPos, 1)
          return(memPos, 0x20)
        }
        arrayPos := add(arrayPos, 0x20)
        if iszero(lt(arrayPos, end)) { break }
      }

      return(memPos, 0x20)
    }
  }
}

// 603c600d600039603c6000f3fe60043560040160208101604051823560051b82015b60011560375782353115602a5760018252602082f35b6020830192508083106014575b602082f3
