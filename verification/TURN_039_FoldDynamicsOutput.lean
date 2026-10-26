import SFT
open SFT.Foundation.FoldDynamicsControls SFT.Host.Canonical
def main : IO Unit := do
  IO.println (render (runControls "sha256:acd6dcb3242eccc57b8e762697dd6bf0d42a977431da610e3971e3b6ffdcd864"))
  IO.println (render closureValue)
