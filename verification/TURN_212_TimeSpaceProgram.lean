import SFT.Computation.TimeSpaceEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TimeSpaceGrammar.candidates do
    match TimeSpaceEvidence.decideCandidate (TimeSpaceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TimeSpaceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TimeSpaceEvidence.registration sourceHash),
    ("census",TimeSpaceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TimeSpaceEvidence.closure decisions),
    ("controls",TimeSpaceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
