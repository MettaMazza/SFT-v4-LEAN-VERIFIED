import SFT.Medicine.ClinicalCauseEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalCauseGrammar.candidates do
    match ClinicalCauseEvidence.decideCandidate (ClinicalCauseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalCauseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalCauseEvidence.registration sourceHash),
    ("census",ClinicalCauseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalCauseEvidence.closure decisions),
    ("controls",ClinicalCauseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
