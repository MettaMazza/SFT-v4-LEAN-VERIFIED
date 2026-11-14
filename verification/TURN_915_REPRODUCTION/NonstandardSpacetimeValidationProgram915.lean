import SFT.Physics.NonstandardSpacetimeValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NonstandardSpacetimeValidationGrammar.candidates do
    match NonstandardSpacetimeValidationEvidence.decideCandidate (NonstandardSpacetimeValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NonstandardSpacetimeValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NonstandardSpacetimeValidationEvidence.registration sourceHash),
    ("census",NonstandardSpacetimeValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NonstandardSpacetimeValidationEvidence.closure decisions),
    ("controls",NonstandardSpacetimeValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
