import SFT.Computation.ParallelAlgorithmEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ParallelAlgorithmGrammar.candidates do
    match ParallelAlgorithmEvidence.decideCandidate (ParallelAlgorithmEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ParallelAlgorithmEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ParallelAlgorithmEvidence.registration sourceHash),
    ("census",ParallelAlgorithmEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ParallelAlgorithmEvidence.closure decisions),
    ("controls",ParallelAlgorithmControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
