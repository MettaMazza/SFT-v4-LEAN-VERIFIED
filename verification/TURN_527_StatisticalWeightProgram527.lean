import SFT.Physics.StatisticalWeightEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StatisticalWeightGrammar.candidates do
    match StatisticalWeightEvidence.decideCandidate (StatisticalWeightEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StatisticalWeightEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StatisticalWeightEvidence.registration sourceHash),
    ("census",StatisticalWeightEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StatisticalWeightEvidence.closure decisions),
    ("controls",StatisticalWeightEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
