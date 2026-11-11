import SFT.Chemistry.PeriodicRecurrenceEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PeriodicRecurrenceGrammar.candidates do
    match PeriodicRecurrenceEvidence.decideCandidate (PeriodicRecurrenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PeriodicRecurrenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PeriodicRecurrenceEvidence.registration sourceHash),
    ("census",PeriodicRecurrenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PeriodicRecurrenceEvidence.closure decisions),
    ("controls",PeriodicRecurrenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
