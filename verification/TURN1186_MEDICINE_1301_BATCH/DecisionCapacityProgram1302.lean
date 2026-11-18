import SFT.Medicine.DecisionCapacityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DecisionCapacityGrammar.candidates do
    match DecisionCapacityEvidence.decideCandidate (DecisionCapacityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DecisionCapacityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DecisionCapacityEvidence.registration sourceHash),
    ("census",DecisionCapacityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DecisionCapacityEvidence.closure decisions),
    ("controls",DecisionCapacityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
