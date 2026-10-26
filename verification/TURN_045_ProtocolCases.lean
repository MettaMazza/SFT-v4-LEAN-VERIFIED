import SFT
open SFT.Foundation.MeasurementProtocol
def main : IO Unit := do
  IO.println (accepts false false false false)
  IO.println (accepts false false false true)
  IO.println (accepts false false true false)
  IO.println (accepts false false true true)
  IO.println (accepts false true false false)
  IO.println (accepts false true false true)
  IO.println (accepts false true true false)
  IO.println (accepts false true true true)
  IO.println (accepts true false false false)
  IO.println (accepts true false false true)
  IO.println (accepts true false true false)
  IO.println (accepts true false true true)
  IO.println (accepts true true false false)
  IO.println (accepts true true false true)
  IO.println (accepts true true true false)
  IO.println (accepts true true true true)
