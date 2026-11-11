import SFT.Chemistry.GroupPeriodEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GroupPeriodGrammar.candidates do
    match GroupPeriodEvidence.decideCandidate (GroupPeriodEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GroupPeriodEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GroupPeriodEvidence.registration sourceHash),
    ("census",GroupPeriodEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GroupPeriodEvidence.closure decisions),
    ("controls",GroupPeriodEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
