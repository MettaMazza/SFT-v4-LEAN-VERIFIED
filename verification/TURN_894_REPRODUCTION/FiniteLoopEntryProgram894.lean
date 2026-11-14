import SFT.Physics.FiniteLoopEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FiniteLoopEntryGrammar.candidates do
    match FiniteLoopEntryEvidence.decideCandidate (FiniteLoopEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FiniteLoopEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FiniteLoopEntryEvidence.registration sourceHash),
    ("census",FiniteLoopEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FiniteLoopEntryEvidence.closure decisions),
    ("controls",FiniteLoopEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
