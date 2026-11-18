import SFT.Medicine.ClinicalEvidenceHandoffEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalEvidenceHandoffGrammar.candidates do
    match ClinicalEvidenceHandoffEvidence.decideCandidate (ClinicalEvidenceHandoffEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalEvidenceHandoffEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalEvidenceHandoffEvidence.registration sourceHash),
    ("census",ClinicalEvidenceHandoffEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalEvidenceHandoffEvidence.closure decisions),
    ("controls",ClinicalEvidenceHandoffEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
