import SFT.Medicine.ClinicalPrivacyEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalPrivacyGrammar.candidates do
    match ClinicalPrivacyEvidence.decideCandidate (ClinicalPrivacyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalPrivacyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalPrivacyEvidence.registration sourceHash),
    ("census",ClinicalPrivacyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalPrivacyEvidence.closure decisions),
    ("controls",ClinicalPrivacyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
