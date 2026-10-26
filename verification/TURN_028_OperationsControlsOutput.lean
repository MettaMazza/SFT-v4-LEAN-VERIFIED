import SFT.Foundation.ExactOperationsControls
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  IO.println (render (.object [
    ("closure",ExactOperationsControls.closureValue),
    ("controls",ExactOperationsControls.runControls (args.headD ""))]))
