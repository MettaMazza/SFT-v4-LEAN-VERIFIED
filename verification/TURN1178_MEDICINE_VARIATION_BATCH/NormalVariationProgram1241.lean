import SFT.Medicine.NormalVariationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NormalVariationGrammar.candidates do
    match NormalVariationEvidence.decideCandidate (NormalVariationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NormalVariationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NormalVariationEvidence.registration sourceHash),
    ("census",NormalVariationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NormalVariationEvidence.closure decisions),
    ("controls",NormalVariationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
