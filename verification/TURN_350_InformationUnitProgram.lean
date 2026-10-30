import SFT.QuantumComputation.InformationUnitEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InformationUnitGrammar.candidates do
    match InformationUnitEvidence.decideCandidate (InformationUnitEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InformationUnitEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InformationUnitEvidence.registration sourceHash),
    ("census",InformationUnitEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InformationUnitEvidence.closure decisions),
    ("controls",InformationUnitControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
