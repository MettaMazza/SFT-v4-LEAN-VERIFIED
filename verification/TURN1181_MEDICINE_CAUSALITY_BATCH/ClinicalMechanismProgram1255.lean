import SFT.Medicine.ClinicalMechanismEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalMechanismGrammar.candidates do
    match ClinicalMechanismEvidence.decideCandidate (ClinicalMechanismEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalMechanismEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalMechanismEvidence.registration sourceHash),
    ("census",ClinicalMechanismEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalMechanismEvidence.closure decisions),
    ("controls",ClinicalMechanismEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
