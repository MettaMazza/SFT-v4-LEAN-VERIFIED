import SFT.QuantumComputation.ComplexityEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComplexityGrammar.candidates do
    match ComplexityEvidence.decideCandidate (ComplexityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComplexityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComplexityEvidence.registration sourceHash),
    ("census",ComplexityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComplexityEvidence.closure decisions),
    ("controls",ComplexityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
