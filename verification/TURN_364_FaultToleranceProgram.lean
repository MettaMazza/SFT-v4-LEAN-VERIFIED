import SFT.QuantumComputation.FaultToleranceEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FaultToleranceGrammar.candidates do
    match FaultToleranceEvidence.decideCandidate (FaultToleranceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FaultToleranceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FaultToleranceEvidence.registration sourceHash),
    ("census",FaultToleranceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FaultToleranceEvidence.closure decisions),
    ("controls",FaultToleranceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
