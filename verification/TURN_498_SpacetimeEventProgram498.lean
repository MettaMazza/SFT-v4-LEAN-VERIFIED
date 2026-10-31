import SFT.Physics.SpacetimeEventEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeEventGrammar.candidates do
    match SpacetimeEventEvidence.decideCandidate (SpacetimeEventEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeEventEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeEventEvidence.registration sourceHash),
    ("census",SpacetimeEventEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeEventEvidence.closure decisions),
    ("controls",SpacetimeEventEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
