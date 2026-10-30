import SFT.Computation.GeneralizationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GeneralizationGrammar.candidates do
    match GeneralizationEvidence.decideCandidate (GeneralizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GeneralizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GeneralizationEvidence.registration sourceHash),
    ("census",GeneralizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GeneralizationEvidence.closure decisions),
    ("controls",GeneralizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
