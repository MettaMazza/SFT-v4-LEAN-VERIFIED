import SFT.Physics.GrandLockEntryEvidence
open SFT.Host.Canonical SFT.Physics
def main (args : List String) : IO Unit := do
 let output ← IO.getStdout
 output.putStrLn (render (GrandLockEntryEvidence.registration (args.headD "")))
