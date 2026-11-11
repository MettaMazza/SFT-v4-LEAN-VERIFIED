import SFT.Chemistry.PeriodicOrderEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PeriodicOrderGrammar.candidates do
    match PeriodicOrderEvidence.decideCandidate (PeriodicOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PeriodicOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PeriodicOrderEvidence.registration sourceHash),
    ("census",PeriodicOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PeriodicOrderEvidence.closure decisions),
    ("controls",PeriodicOrderEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
