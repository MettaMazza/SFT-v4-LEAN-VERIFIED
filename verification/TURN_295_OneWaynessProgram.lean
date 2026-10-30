import SFT.Computation.OneWaynessEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OneWaynessGrammar.candidates do
    match OneWaynessEvidence.decideCandidate (OneWaynessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OneWaynessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OneWaynessEvidence.registration sourceHash),
    ("census",OneWaynessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OneWaynessEvidence.closure decisions),
    ("controls",OneWaynessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
