import SFT.Chemistry.AromaticRecurrenceEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AromaticRecurrenceGrammar.candidates do
    match AromaticRecurrenceEvidence.decideCandidate (AromaticRecurrenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AromaticRecurrenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AromaticRecurrenceEvidence.registration sourceHash),
    ("census",AromaticRecurrenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AromaticRecurrenceEvidence.closure decisions),
    ("controls",AromaticRecurrenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
