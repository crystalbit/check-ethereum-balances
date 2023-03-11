object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
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

// 6039600d60003960396000f3fe60003560208101813560051b81015b60011560335781353115602657600160805260206080f35b602082019150808210600e575b60206060f3
