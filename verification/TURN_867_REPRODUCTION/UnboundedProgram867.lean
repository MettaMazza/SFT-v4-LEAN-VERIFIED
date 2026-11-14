import SFT.QuantumComputation.UnboundedEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UnboundedGrammar.candidates do
    match UnboundedEvidence.decideCandidate (UnboundedEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UnboundedEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UnboundedEvidence.registration sourceHash),
    ("census",UnboundedEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UnboundedEvidence.closure decisions),
    ("controls",UnboundedEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
