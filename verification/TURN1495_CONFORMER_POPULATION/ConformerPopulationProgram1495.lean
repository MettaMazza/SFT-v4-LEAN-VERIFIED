import SFT.Chemistry.ConformerPopulationEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConformerPopulationGrammar.candidates do
    match ConformerPopulationEvidence.decideCandidate (ConformerPopulationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConformerPopulationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConformerPopulationEvidence.registration sourceHash),
    ("census",ConformerPopulationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConformerPopulationEvidence.closure decisions),
    ("controls",ConformerPopulationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
