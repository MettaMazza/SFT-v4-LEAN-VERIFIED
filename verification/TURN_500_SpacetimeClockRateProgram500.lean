import SFT.Physics.SpacetimeClockRateEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeClockRateGrammar.candidates do
    match SpacetimeClockRateEvidence.decideCandidate (SpacetimeClockRateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeClockRateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeClockRateEvidence.registration sourceHash),
    ("census",SpacetimeClockRateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeClockRateEvidence.closure decisions),
    ("controls",SpacetimeClockRateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
