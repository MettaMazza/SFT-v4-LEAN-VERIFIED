import SFT.Medicine.ClinicalResponseEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalResponseGrammar.candidates do
    match ClinicalResponseEvidence.decideCandidate (ClinicalResponseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalResponseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalResponseEvidence.registration sourceHash),
    ("census",ClinicalResponseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalResponseEvidence.closure decisions),
    ("controls",ClinicalResponseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
