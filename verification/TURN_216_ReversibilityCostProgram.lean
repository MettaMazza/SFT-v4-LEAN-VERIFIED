import SFT.Computation.ReversibilityCostEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ReversibilityCostGrammar.candidates do
    match ReversibilityCostEvidence.decideCandidate (ReversibilityCostEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ReversibilityCostEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ReversibilityCostEvidence.registration sourceHash),
    ("census",ReversibilityCostEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ReversibilityCostEvidence.closure decisions),
    ("controls",ReversibilityCostControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
