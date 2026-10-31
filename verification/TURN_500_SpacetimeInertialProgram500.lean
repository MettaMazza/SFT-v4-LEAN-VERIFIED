import SFT.Physics.SpacetimeInertialEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpacetimeInertialGrammar.candidates do
    match SpacetimeInertialEvidence.decideCandidate (SpacetimeInertialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpacetimeInertialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpacetimeInertialEvidence.registration sourceHash),
    ("census",SpacetimeInertialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpacetimeInertialEvidence.closure decisions),
    ("controls",SpacetimeInertialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
