import SFT.Medicine.ClinicalTrialEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalTrialGrammar.candidates do
    match ClinicalTrialEvidence.decideCandidate (ClinicalTrialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalTrialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalTrialEvidence.registration sourceHash),
    ("census",ClinicalTrialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalTrialEvidence.closure decisions),
    ("controls",ClinicalTrialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
