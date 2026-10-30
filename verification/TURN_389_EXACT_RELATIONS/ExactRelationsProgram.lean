import SFT.Mathematics.ExactRelationsEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ExactRelationsGrammar.candidates do
    match ExactRelationsEvidence.decideCandidate (ExactRelationsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ExactRelationsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ExactRelationsEvidence.registration sourceHash),
    ("census",ExactRelationsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ExactRelationsEvidence.closure decisions),
    ("controls",ExactRelationsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
