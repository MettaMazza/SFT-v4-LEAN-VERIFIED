import SFT.Computation.ReductionCompletenessEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ReductionCompletenessGrammar.candidates do
    match ReductionCompletenessEvidence.decideCandidate (ReductionCompletenessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ReductionCompletenessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ReductionCompletenessEvidence.registration sourceHash),
    ("census",ReductionCompletenessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ReductionCompletenessEvidence.closure decisions),
    ("controls",ReductionCompletenessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
