import SFT.Computation.IncompletenessEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IncompletenessGrammar.candidates do
    match IncompletenessEvidence.decideCandidate (IncompletenessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IncompletenessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IncompletenessEvidence.registration sourceHash),
    ("census",IncompletenessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IncompletenessEvidence.closure decisions),
    ("controls",IncompletenessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
