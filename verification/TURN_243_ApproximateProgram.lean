import SFT.Computation.ApproximateEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ApproximateGrammar.candidates do
    match ApproximateEvidence.decideCandidate (ApproximateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ApproximateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ApproximateEvidence.registration sourceHash),
    ("census",ApproximateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ApproximateEvidence.closure decisions),
    ("controls",ApproximateControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
