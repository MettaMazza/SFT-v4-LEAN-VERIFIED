import SFT.Medicine.ClinicalDecisionEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalDecisionGrammar.candidates do
    match ClinicalDecisionEvidence.decideCandidate (ClinicalDecisionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalDecisionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalDecisionEvidence.registration sourceHash),
    ("census",ClinicalDecisionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalDecisionEvidence.closure decisions),
    ("controls",ClinicalDecisionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
