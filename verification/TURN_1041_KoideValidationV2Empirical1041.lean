import SFT.Physics.KoideValidationV2External
open SFT.Physics SFT.Host.Canonical
def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let body ← IO.FS.readFile (root ++ "/" ++ KoideValidationV2Experiment.sourcePath)
 let result ← IO.ofExcept (KoideValidationV2External.validate body derivationSeal host implementation before before)
 IO.println (render result.value)
