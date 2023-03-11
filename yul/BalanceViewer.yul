object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      // use any selector. for example, 0xeb340184: detectBalance(address[])

      let offset := calldataload(0)
      let arrayPos := add(offset, 0x20)

      let end := add(arrayPos, shl(5, calldataload(offset)))
      for { } 1 { } {
        if balance(calldataload(arrayPos))
        {
          mstore(0x80, 1)
          return(0x80, 0x20)
        }
        arrayPos := add(arrayPos, 0x20)
        if iszero(lt(arrayPos, end)) { break }
      }
      return(0x60, 0x20)
    }
  }
}

// 603c600d600039603c6000f3fe60043560040160208101813560051b81015b60011560365781353115602957600160805260206080f35b6020820191508082106011575b60206060f3
