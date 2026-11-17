import SFT.Physics.GrandLockEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
 let sourceHash := args.headD ""
 if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
 let output ← IO.getStdout
 output.putStr "{\"decisions\":["
 let mut decisions : List SFT.Engine.CandidateDecision := []
 let mut first := true
 for c in GrandLockGrammar.candidates do
  match GrandLockEntryEvidence.decideCandidate (GrandLockEntryEvidence.generatedCandidateData c) with
  | .ok decision =>
   if !first then output.putStr ","
   output.putStr (render (SFT.Engine.decisionValue decision))
   output.flush
   first := false
   decisions := decisions ++ [decision]
  | .error e => throw (IO.userError e)
 output.putStr "]"
 let unknown := match GrandLockEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
  | .error e => e
  | .ok _ => "incorrectly accepted"
 for (name,value) in [
  ("registration",GrandLockEntryEvidence.registration sourceHash),
  ("census",GrandLockEntryEvidence.census),
  ("closure",GrandLockEntryEvidence.closure decisions),
  ("controls",GrandLockEntryEvidence.runControls sourceHash),
  ("unknown_id",.text unknown)] do
  output.putStr ("," ++ quote name ++ ":")
  output.putStr (render value)
  output.flush
 output.putStr "}\n"
