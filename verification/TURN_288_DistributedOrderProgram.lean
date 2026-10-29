import SFT.Computation.DistributedOrderEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DistributedOrderGrammar.candidates do
    match DistributedOrderEvidence.decideCandidate (DistributedOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DistributedOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DistributedOrderEvidence.registration sourceHash),
    ("census",DistributedOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DistributedOrderEvidence.closure decisions),
    ("controls",DistributedOrderControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
