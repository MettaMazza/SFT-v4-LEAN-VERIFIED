import SFT.Computation.ExactApproximateEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ExactApproximateGrammar.candidates do
    match ExactApproximateEvidence.decideCandidate (ExactApproximateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ExactApproximateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ExactApproximateEvidence.registration sourceHash),
    ("census",ExactApproximateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ExactApproximateEvidence.closure decisions),
    ("controls",ExactApproximateControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
