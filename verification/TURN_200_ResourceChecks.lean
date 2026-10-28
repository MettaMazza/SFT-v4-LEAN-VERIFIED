import SFT.Computation.ResourceRecord
open SFT.Host.Canonical SFT.Computation.ResourceRecord
def value (result : Except String Ledger) : Value := match result with
 | .error e => .object [("error",.text e)]
 | .ok l => .object [("time_trace",.array (l.timeTrace.map fun p => .array [.text p.1,.text p.2])),("space_support",.array (l.spaceSupport.map Value.text)),("time_count",.integer (Int.ofNat l.timeCount)),("space_count",.integer (Int.ofNat l.spaceCount))]
def main : IO Unit := do
  IO.println (render (.array [
value (resourceLedger [] []),
value (resourceLedger [] ["a"]),
value (resourceLedger [] ["a","b"]),
value (resourceLedger [] ["a","a"]),
value (resourceLedger [] ["μ","x"]),
value (resourceLedger [] ["a","b","a"]),
value (resourceLedger ["held"] []),
value (resourceLedger ["held"] ["a"]),
value (resourceLedger ["held"] ["a","b"]),
value (resourceLedger ["held"] ["a","a"]),
value (resourceLedger ["held"] ["μ","x"]),
value (resourceLedger ["held"] ["a","b","a"]),
value (resourceLedger ["held","returned"] []),
value (resourceLedger ["held","returned"] ["a"]),
value (resourceLedger ["held","returned"] ["a","b"]),
value (resourceLedger ["held","returned"] ["a","a"]),
value (resourceLedger ["held","returned"] ["μ","x"]),
value (resourceLedger ["held","returned"] ["a","b","a"]),
value (resourceLedger ["a","a"] []),
value (resourceLedger ["a","a"] ["a"]),
value (resourceLedger ["a","a"] ["a","b"]),
value (resourceLedger ["a","a"] ["a","a"]),
value (resourceLedger ["a","a"] ["μ","x"]),
value (resourceLedger ["a","a"] ["a","b","a"]),
value (resourceLedger ["μ","empty-One"] []),
value (resourceLedger ["μ","empty-One"] ["a"]),
value (resourceLedger ["μ","empty-One"] ["a","b"]),
value (resourceLedger ["μ","empty-One"] ["a","a"]),
value (resourceLedger ["μ","empty-One"] ["μ","x"]),
value (resourceLedger ["μ","empty-One"] ["a","b","a"]),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] []),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] ["a"]),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] ["a","b"]),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] ["a","a"]),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] ["μ","x"]),
value (resourceLedger ["x","x","x","x","x","x","x","x","x","x","x","x"] ["a","b","a"])]))
