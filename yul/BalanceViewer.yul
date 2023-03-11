object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      // let offset := 0
      let arrayPos := 0

      // let end := mul(1024, 0x20) // add(arrayPos, shl(5, calldataload(offset)))
      for { } 1 { } {
        if balance(calldataload(arrayPos))
        {
          mstore(0x80, 1)
          return(0x80, 0x20)
        }
        arrayPos := add(arrayPos, 0x20)
        if iszero(lt(arrayPos, mul(1024, 0x20))) { break }
      }
      return(0x60, 0x20)
    }
  }
}

// 603c600d600039603c6000f3fe60043560040160208101813560051b81015b60011560365781353115602957600160805260206080f35b6020820191508082106011575b60206060f3
// 6039600d60003960396000f3fe60003560208101813560051b81015b60011560335781353115602657600160805260206080f35b602082019150808210600e575b60206060f3
// 6032600d60003960326000f3fe60005b600115602c5780353115601a57600160805260206080f35b60208101905060206104000281106002575b60206060f3
