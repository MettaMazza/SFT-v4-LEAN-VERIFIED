import SFT.QuantumComputation.StateCompositionEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StateCompositionGrammar.candidates do
    match StateCompositionEvidence.decideCandidate (StateCompositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StateCompositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StateCompositionEvidence.registration sourceHash),
    ("census",StateCompositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StateCompositionEvidence.closure decisions),
    ("controls",StateCompositionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
