import SFT.Medicine.ClinicalToxicityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalToxicityGrammar.candidates do
    match ClinicalToxicityEvidence.decideCandidate (ClinicalToxicityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalToxicityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalToxicityEvidence.registration sourceHash),
    ("census",ClinicalToxicityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalToxicityEvidence.closure decisions),
    ("controls",ClinicalToxicityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
