import SFT.Physics.GrandLockEntryEvidence
import Lean
open SFT.Host.Canonical SFT.Physics

def decodeDecision (j : Lean.Json) : Except String SFT.Engine.CandidateDecision := do
 return ⟨← j.getObjValAs? String "candidate_id",← j.getObjValAs? Bool "survives",
  ← j.getObjValAs? String "reason",← j.getObjValAs? String "proof_hash"⟩
def main (args : List String) : IO Unit := do
 let sourceHash := args.headD ""
 if sourceHash.isEmpty then throw (IO.userError "Pass pinned source manifest hash")
 let raw ← IO.FS.readFile "work/grandlock1112_all_decisions.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let array ← IO.ofExcept input.getArr?
 let decisions ← IO.ofExcept (array.toList.mapM decodeDecision)
 if decisions.length != GrandLockGrammar.candidates.length then throw (IO.userError "incomplete decision census")
 let unknown := match GrandLockEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
  | .error e => e
  | .ok _ => "incorrectly accepted"
 let output ← IO.getStdout
 output.putStr "{"
 let mut first := true
 for (name,value) in [("registration",GrandLockEntryEvidence.registration sourceHash),
  ("census",GrandLockEntryEvidence.census),("closure",GrandLockEntryEvidence.closure decisions),
  ("controls",GrandLockEntryEvidence.runControls sourceHash),("unknown_id",.text unknown)] do
  if !first then output.putStr ","
  first := false
  output.putStr (quote name ++ ":" ++ render value)
  output.flush
 output.putStrLn "}"
