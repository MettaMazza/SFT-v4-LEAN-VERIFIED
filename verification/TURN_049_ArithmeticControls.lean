import SFT
open SFT.Mathematics.ExactArithmeticControls SFT.Host.Canonical
def main : IO Unit := do
  IO.println (render (runControls "sha256:db8d9a5838f2f84cd04cd3425e0faa5232ec8afb6461f1a7fe62ab9f6263246f"))
  IO.println (render closureValue)
  IO.println survivorIds.length
  IO.println distinctIdentifiers.length
