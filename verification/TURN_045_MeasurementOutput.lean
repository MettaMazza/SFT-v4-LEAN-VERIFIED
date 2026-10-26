import SFT
open SFT.Foundation.MeasurementControls SFT.Host.Canonical
def main : IO Unit := do
  IO.println (render (runControls "sha256:00826bd4ce69aa55d2530c6259546fd4f58f42f4a3643d04ea3416402c21b3f7"))
  IO.println (render closureValue)
