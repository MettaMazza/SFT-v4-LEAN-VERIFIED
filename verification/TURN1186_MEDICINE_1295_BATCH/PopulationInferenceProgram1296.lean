import SFT.Medicine.PopulationInferenceEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PopulationInferenceGrammar.candidates do
    match PopulationInferenceEvidence.decideCandidate (PopulationInferenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PopulationInferenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PopulationInferenceEvidence.registration sourceHash),
    ("census",PopulationInferenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PopulationInferenceEvidence.closure decisions),
    ("controls",PopulationInferenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
