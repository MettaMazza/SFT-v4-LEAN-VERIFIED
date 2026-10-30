import SFT.QuantumComputation.SuperpositionEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SuperpositionGrammar.candidates do
    match SuperpositionEvidence.decideCandidate (SuperpositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SuperpositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SuperpositionEvidence.registration sourceHash),
    ("census",SuperpositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SuperpositionEvidence.closure decisions),
    ("controls",SuperpositionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
