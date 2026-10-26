import SFT.Foundation.HalfOneControls
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  IO.println (render (.object [
    ("closure",HalfOneControls.closureValue),
    ("controls",HalfOneControls.runControls (args.headD ""))]))
