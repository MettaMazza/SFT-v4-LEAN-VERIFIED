import SFT.Physics.DiscreteSpectraEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiscreteSpectraGrammar.candidates do
    match DiscreteSpectraEvidence.decideCandidate (DiscreteSpectraEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiscreteSpectraEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiscreteSpectraEvidence.registration sourceHash),
    ("census",DiscreteSpectraEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiscreteSpectraEvidence.closure decisions),
    ("controls",DiscreteSpectraEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
