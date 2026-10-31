import SFT.Physics.SpacetimeLimitSpeedEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeLimitSpeedGrammar.candidates do
    match SpacetimeLimitSpeedEvidence.decideCandidate (SpacetimeLimitSpeedEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeLimitSpeedEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeLimitSpeedEvidence.registration sourceHash),
    ("census",SpacetimeLimitSpeedEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeLimitSpeedEvidence.closure decisions),
    ("controls",SpacetimeLimitSpeedEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
