import SFT.QuantumComputation.GateLawEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GateLawGrammar.candidates do
    match GateLawEvidence.decideCandidate (GateLawEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GateLawEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GateLawEvidence.registration sourceHash),
    ("census",GateLawEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GateLawEvidence.closure decisions),
    ("controls",GateLawControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
