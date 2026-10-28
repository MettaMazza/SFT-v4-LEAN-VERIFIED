import SFT.InformationScience.QuantumEvidence
open SFT.Host.Canonical SFT.InformationScience

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuantumGrammar.candidates do
    match QuantumEvidence.decideCandidate (QuantumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuantumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuantumEvidence.registration sourceHash),
    ("census",QuantumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuantumEvidence.closure decisions),
    ("controls",QuantumControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
