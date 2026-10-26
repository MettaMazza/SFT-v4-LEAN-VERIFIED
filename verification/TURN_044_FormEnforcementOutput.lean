import SFT
open SFT.Foundation.FormEnforcementControls SFT.Host.Canonical
def main : IO Unit := do
  IO.println (render (runControls "sha256:77f0f0255530e33fff3a7caa1b8728c0df86f76ce314ec4051a834f495f74c9c"))
  IO.println (render closureValue)
