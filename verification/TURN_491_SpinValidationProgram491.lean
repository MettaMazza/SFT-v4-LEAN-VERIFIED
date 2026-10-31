import SFT.Physics.SpinValidation
open SFT.Physics SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 let bytes ← IO.FS.readBinFile (args[0]!)
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 match SpinValidation.validate bytes (args[1]!) (args[2]!) (args[3]!) before before with
 | .error e => throw (IO.userError e)
 | .ok result => IO.println (render result.value)
