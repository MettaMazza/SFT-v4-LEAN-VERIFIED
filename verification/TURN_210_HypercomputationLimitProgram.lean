import SFT.Computation.HypercomputationLimitEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HypercomputationLimitGrammar.candidates do
    match HypercomputationLimitEvidence.decideCandidate (HypercomputationLimitEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HypercomputationLimitEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HypercomputationLimitEvidence.registration sourceHash),
    ("census",HypercomputationLimitEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HypercomputationLimitEvidence.closure decisions),
    ("controls",HypercomputationLimitControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
