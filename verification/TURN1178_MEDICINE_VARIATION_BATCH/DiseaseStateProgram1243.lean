import SFT.Medicine.DiseaseStateEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiseaseStateGrammar.candidates do
    match DiseaseStateEvidence.decideCandidate (DiseaseStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiseaseStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiseaseStateEvidence.registration sourceHash),
    ("census",DiseaseStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiseaseStateEvidence.closure decisions),
    ("controls",DiseaseStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
