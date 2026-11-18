import SFT.Medicine.ClinicalRiskEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalRiskGrammar.candidates do
    match ClinicalRiskEvidence.decideCandidate (ClinicalRiskEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalRiskEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalRiskEvidence.registration sourceHash),
    ("census",ClinicalRiskEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalRiskEvidence.closure decisions),
    ("controls",ClinicalRiskEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
