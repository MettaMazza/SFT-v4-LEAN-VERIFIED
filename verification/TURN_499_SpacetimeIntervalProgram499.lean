import SFT.Physics.SpacetimeIntervalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeIntervalGrammar.candidates do
    match SpacetimeIntervalEvidence.decideCandidate (SpacetimeIntervalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeIntervalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeIntervalEvidence.registration sourceHash),
    ("census",SpacetimeIntervalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeIntervalEvidence.closure decisions),
    ("controls",SpacetimeIntervalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
