import SFT.Physics.SpeedRelationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpeedRelationGrammar.candidates do
    match SpeedRelationEvidence.decideCandidate (SpeedRelationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpeedRelationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpeedRelationEvidence.registration sourceHash),
    ("census",SpeedRelationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpeedRelationEvidence.closure decisions),
    ("controls",SpeedRelationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
