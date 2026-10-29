import SFT.Computation.SearchOrderEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SearchOrderGrammar.candidates do
    match SearchOrderEvidence.decideCandidate (SearchOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SearchOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SearchOrderEvidence.registration sourceHash),
    ("census",SearchOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SearchOrderEvidence.closure decisions),
    ("controls",SearchOrderControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
