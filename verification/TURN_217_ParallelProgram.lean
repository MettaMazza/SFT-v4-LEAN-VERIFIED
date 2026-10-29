import SFT.Computation.ParallelEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ParallelGrammar.candidates do
    match ParallelEvidence.decideCandidate (ParallelEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ParallelEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ParallelEvidence.registration sourceHash),
    ("census",ParallelEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ParallelEvidence.closure decisions),
    ("controls",ParallelControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
