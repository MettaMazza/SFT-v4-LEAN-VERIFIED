import SFT.QuantumComputation.CommunicationEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CommunicationGrammar.candidates do
    match CommunicationEvidence.decideCandidate (CommunicationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CommunicationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CommunicationEvidence.registration sourceHash),
    ("census",CommunicationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CommunicationEvidence.closure decisions),
    ("controls",CommunicationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
