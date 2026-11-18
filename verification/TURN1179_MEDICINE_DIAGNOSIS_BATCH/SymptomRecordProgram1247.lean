import SFT.Medicine.SymptomRecordEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SymptomRecordGrammar.candidates do
    match SymptomRecordEvidence.decideCandidate (SymptomRecordEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SymptomRecordEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SymptomRecordEvidence.registration sourceHash),
    ("census",SymptomRecordEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SymptomRecordEvidence.closure decisions),
    ("controls",SymptomRecordEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
