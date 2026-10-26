import SFT
open SFT.Foundation.FormControls SFT.Host.Canonical
def main : IO Unit := do
  IO.println (render (runControls "sha256:ff7dd1129dc75d783f34d0e8878028bbcfc74eadb3f4124ce5c40e8cd62efa27"))
  IO.println (render closureValue)
