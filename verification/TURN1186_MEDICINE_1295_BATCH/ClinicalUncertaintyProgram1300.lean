import SFT.Medicine.ClinicalUncertaintyEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalUncertaintyGrammar.candidates do
    match ClinicalUncertaintyEvidence.decideCandidate (ClinicalUncertaintyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalUncertaintyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalUncertaintyEvidence.registration sourceHash),
    ("census",ClinicalUncertaintyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalUncertaintyEvidence.closure decisions),
    ("controls",ClinicalUncertaintyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
