import SFT.Medicine.ClinicalExposureEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalExposureGrammar.candidates do
    match ClinicalExposureEvidence.decideCandidate (ClinicalExposureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalExposureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalExposureEvidence.registration sourceHash),
    ("census",ClinicalExposureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalExposureEvidence.closure decisions),
    ("controls",ClinicalExposureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
