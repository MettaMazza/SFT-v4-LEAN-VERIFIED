import SFT.Computation.ConcurrencyEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConcurrencyGrammar.candidates do
    match ConcurrencyEvidence.decideCandidate (ConcurrencyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConcurrencyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConcurrencyEvidence.registration sourceHash),
    ("census",ConcurrencyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConcurrencyEvidence.closure decisions),
    ("controls",ConcurrencyControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
