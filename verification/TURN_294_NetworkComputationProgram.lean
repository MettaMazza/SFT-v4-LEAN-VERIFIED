import SFT.Computation.NetworkComputationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NetworkComputationGrammar.candidates do
    match NetworkComputationEvidence.decideCandidate (NetworkComputationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NetworkComputationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NetworkComputationEvidence.registration sourceHash),
    ("census",NetworkComputationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NetworkComputationEvidence.closure decisions),
    ("controls",NetworkComputationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
