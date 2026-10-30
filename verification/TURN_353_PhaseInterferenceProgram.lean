import SFT.QuantumComputation.PhaseInterferenceEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhaseInterferenceGrammar.candidates do
    match PhaseInterferenceEvidence.decideCandidate (PhaseInterferenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhaseInterferenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhaseInterferenceEvidence.registration sourceHash),
    ("census",PhaseInterferenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhaseInterferenceEvidence.closure decisions),
    ("controls",PhaseInterferenceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
