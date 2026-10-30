import SFT.QuantumComputation.AlgorithmsEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AlgorithmsGrammar.candidates do
    match AlgorithmsEvidence.decideCandidate (AlgorithmsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AlgorithmsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AlgorithmsEvidence.registration sourceHash),
    ("census",AlgorithmsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AlgorithmsEvidence.closure decisions),
    ("controls",AlgorithmsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
