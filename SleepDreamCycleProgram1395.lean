import SFT.Consciousness.SleepDreamCycleEvidence
open SFT.Host.Canonical SFT.Consciousness

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SleepDreamCycleGrammar.candidates do
    match SleepDreamCycleEvidence.decideCandidate (SleepDreamCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SleepDreamCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SleepDreamCycleEvidence.registration sourceHash),
    ("census",SleepDreamCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SleepDreamCycleEvidence.closure decisions),
    ("controls",SleepDreamCycleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
