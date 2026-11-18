import SFT.Medicine.ClinicalAssociationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalAssociationGrammar.candidates do
    match ClinicalAssociationEvidence.decideCandidate (ClinicalAssociationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalAssociationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalAssociationEvidence.registration sourceHash),
    ("census",ClinicalAssociationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalAssociationEvidence.closure decisions),
    ("controls",ClinicalAssociationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
