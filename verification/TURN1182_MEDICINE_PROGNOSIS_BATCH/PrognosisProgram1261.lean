import SFT.Medicine.PrognosisEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PrognosisGrammar.candidates do
    match PrognosisEvidence.decideCandidate (PrognosisEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PrognosisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PrognosisEvidence.registration sourceHash),
    ("census",PrognosisEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PrognosisEvidence.closure decisions),
    ("controls",PrognosisEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
