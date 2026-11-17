import SFT.Chemistry.IsotopeExchangeEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IsotopeExchangeGrammar.candidates do
    match IsotopeExchangeEvidence.decideCandidate (IsotopeExchangeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IsotopeExchangeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IsotopeExchangeEvidence.registration sourceHash),
    ("census",IsotopeExchangeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IsotopeExchangeEvidence.closure decisions),
    ("controls",IsotopeExchangeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
