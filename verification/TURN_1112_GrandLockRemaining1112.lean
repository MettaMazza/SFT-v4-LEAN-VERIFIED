import SFT.Physics.GrandLockEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
 let start ← match (args[0]?.getD "").toNat? with
  | some n => pure n
  | none => throw (IO.userError "start required")
 let count ← match (args[1]?.getD "").toNat? with
  | some n => pure n
  | none => throw (IO.userError "count required")
 if start+count > GrandLockGrammar.candidates.length then throw (IO.userError "range exceeds original census")
 let output ← IO.getStdout
 for c in (GrandLockGrammar.candidates.drop start).take count do
  match GrandLockEntryEvidence.decideCandidate (GrandLockEntryEvidence.generatedCandidateData c) with
  | .ok decision =>
   output.putStrLn (render (SFT.Engine.decisionValue decision))
   output.flush
  | .error e => throw (IO.userError e)
