import SFT.Physics.SpacetimeCausalOrderEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeCausalOrderGrammar.candidates do
    match SpacetimeCausalOrderEvidence.decideCandidate (SpacetimeCausalOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeCausalOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeCausalOrderEvidence.registration sourceHash),
    ("census",SpacetimeCausalOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeCausalOrderEvidence.closure decisions),
    ("controls",SpacetimeCausalOrderEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
