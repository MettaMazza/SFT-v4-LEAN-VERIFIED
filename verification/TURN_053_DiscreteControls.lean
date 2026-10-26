import SFT.Mathematics.DiscreteControls
open SFT.Host.Canonical
open SFT.Mathematics.DiscreteControls

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  IO.println (render (.object [
    ("closure",closureValue),
    ("controls",runControls sourceHash),
    ("survivor_count",.integer (Int.ofNat survivorIds.length)),
    ("distinct_identifiers",.integer (Int.ofNat distinctIdentifiers.length))]))
