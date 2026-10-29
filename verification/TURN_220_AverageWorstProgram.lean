import SFT.Computation.AverageWorstEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AverageWorstGrammar.candidates do
    match AverageWorstEvidence.decideCandidate (AverageWorstEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AverageWorstEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AverageWorstEvidence.registration sourceHash),
    ("census",AverageWorstEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AverageWorstEvidence.closure decisions),
    ("controls",AverageWorstControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
