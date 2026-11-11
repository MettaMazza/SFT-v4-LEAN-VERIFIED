import SFT.Chemistry.TraceabilityEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TraceabilityGrammar.candidates do
    match TraceabilityEvidence.decideCandidate (TraceabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TraceabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TraceabilityEvidence.registration sourceHash),
    ("census",TraceabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TraceabilityEvidence.closure decisions),
    ("controls",TraceabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
