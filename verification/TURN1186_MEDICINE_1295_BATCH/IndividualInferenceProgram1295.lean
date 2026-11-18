import SFT.Medicine.IndividualInferenceEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IndividualInferenceGrammar.candidates do
    match IndividualInferenceEvidence.decideCandidate (IndividualInferenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IndividualInferenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IndividualInferenceEvidence.registration sourceHash),
    ("census",IndividualInferenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IndividualInferenceEvidence.closure decisions),
    ("controls",IndividualInferenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
