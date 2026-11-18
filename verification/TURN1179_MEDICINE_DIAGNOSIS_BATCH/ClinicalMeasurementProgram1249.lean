import SFT.Medicine.ClinicalMeasurementEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalMeasurementGrammar.candidates do
    match ClinicalMeasurementEvidence.decideCandidate (ClinicalMeasurementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalMeasurementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalMeasurementEvidence.registration sourceHash),
    ("census",ClinicalMeasurementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalMeasurementEvidence.closure decisions),
    ("controls",ClinicalMeasurementEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
