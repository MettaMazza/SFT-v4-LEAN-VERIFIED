import SFT.Computation.ScientificSymbolicEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ScientificSymbolicGrammar.candidates do
    match ScientificSymbolicEvidence.decideCandidate (ScientificSymbolicEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ScientificSymbolicEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ScientificSymbolicEvidence.registration sourceHash),
    ("census",ScientificSymbolicEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ScientificSymbolicEvidence.closure decisions),
    ("controls",ScientificSymbolicControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
