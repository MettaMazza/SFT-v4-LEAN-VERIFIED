import SFT.Computation.DistributedAlgorithmEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DistributedAlgorithmGrammar.candidates do
    match DistributedAlgorithmEvidence.decideCandidate (DistributedAlgorithmEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DistributedAlgorithmEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DistributedAlgorithmEvidence.registration sourceHash),
    ("census",DistributedAlgorithmEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DistributedAlgorithmEvidence.closure decisions),
    ("controls",DistributedAlgorithmControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
