import SFT.Computation.CircuitResourceEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CircuitResourceGrammar.candidates do
    match CircuitResourceEvidence.decideCandidate (CircuitResourceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CircuitResourceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CircuitResourceEvidence.registration sourceHash),
    ("census",CircuitResourceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CircuitResourceEvidence.closure decisions),
    ("controls",CircuitResourceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
