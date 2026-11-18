import SFT.Medicine.ClinicalOutcomeEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalOutcomeGrammar.candidates do
    match ClinicalOutcomeEvidence.decideCandidate (ClinicalOutcomeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalOutcomeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalOutcomeEvidence.registration sourceHash),
    ("census",ClinicalOutcomeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalOutcomeEvidence.closure decisions),
    ("controls",ClinicalOutcomeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
