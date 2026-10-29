import SFT.Computation.ApproximationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ApproximationGrammar.candidates do
    match ApproximationEvidence.decideCandidate (ApproximationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ApproximationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ApproximationEvidence.registration sourceHash),
    ("census",ApproximationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ApproximationEvidence.closure decisions),
    ("controls",ApproximationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
