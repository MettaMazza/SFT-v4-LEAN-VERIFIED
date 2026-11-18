import SFT.Medicine.SeverityStageEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SeverityStageGrammar.candidates do
    match SeverityStageEvidence.decideCandidate (SeverityStageEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SeverityStageEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SeverityStageEvidence.registration sourceHash),
    ("census",SeverityStageEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SeverityStageEvidence.closure decisions),
    ("controls",SeverityStageEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
