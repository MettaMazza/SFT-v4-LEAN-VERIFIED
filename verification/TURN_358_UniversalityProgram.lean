import SFT.QuantumComputation.UniversalityEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UniversalityGrammar.candidates do
    match UniversalityEvidence.decideCandidate (UniversalityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UniversalityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UniversalityEvidence.registration sourceHash),
    ("census",UniversalityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UniversalityEvidence.closure decisions),
    ("controls",UniversalityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
