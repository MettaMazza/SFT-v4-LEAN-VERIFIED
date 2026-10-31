import SFT.Physics.SpacetimeLengthRelationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeLengthRelationGrammar.candidates do
    match SpacetimeLengthRelationEvidence.decideCandidate (SpacetimeLengthRelationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeLengthRelationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeLengthRelationEvidence.registration sourceHash),
    ("census",SpacetimeLengthRelationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeLengthRelationEvidence.closure decisions),
    ("controls",SpacetimeLengthRelationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
