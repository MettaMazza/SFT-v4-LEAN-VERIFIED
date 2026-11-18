import SFT.Medicine.CounterfactualEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CounterfactualGrammar.candidates do
    match CounterfactualEvidence.decideCandidate (CounterfactualEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CounterfactualEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CounterfactualEvidence.registration sourceHash),
    ("census",CounterfactualEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CounterfactualEvidence.closure decisions),
    ("controls",CounterfactualEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
