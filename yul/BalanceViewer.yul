object "BalanceViewer" {
  code {
    datacopy(0, dataoffset("Runtime"), datasize("Runtime"))
    return(0, datasize("Runtime"))
  }
  object "Runtime" {
    code {
      let arrayPos := 0

      for { } 1 { } {
        if balance(calldataload(arrayPos))
        {
          mstore(0x80, 1)
          return(0x80, 0x20)
        }
        arrayPos := add(arrayPos, 0x20)
        if iszero(lt(arrayPos, 32000)) { break } // 32000 means 32 bytes 1000 times
      }
      return(0x60, 0x20)
    }
  }
}

// 602f600d600039602f6000f3fe60005b60011560295780353115601a57600160805260206080f35b602081019050617d0081106002575b60206060f3
