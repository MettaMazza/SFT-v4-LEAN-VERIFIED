import SFT.Physics.ConstraintOscillationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConstraintOscillationGrammar.candidates do
    match ConstraintOscillationEvidence.decideCandidate (ConstraintOscillationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConstraintOscillationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConstraintOscillationEvidence.registration sourceHash),
    ("census",ConstraintOscillationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConstraintOscillationEvidence.closure decisions),
    ("controls",ConstraintOscillationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
