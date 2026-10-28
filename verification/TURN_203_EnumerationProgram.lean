import SFT.Computation.EnumerationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EnumerationGrammar.candidates do
    match EnumerationEvidence.decideCandidate (EnumerationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EnumerationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EnumerationEvidence.registration sourceHash),
    ("census",EnumerationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EnumerationEvidence.closure decisions),
    ("controls",EnumerationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
