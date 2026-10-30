import SFT.Computation.DiscretizationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiscretizationGrammar.candidates do
    match DiscretizationEvidence.decideCandidate (DiscretizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiscretizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiscretizationEvidence.registration sourceHash),
    ("census",DiscretizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiscretizationEvidence.closure decisions),
    ("controls",DiscretizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
