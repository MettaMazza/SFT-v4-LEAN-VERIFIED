import SFT.AstronomyCosmology.AstronomicalPopulationEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalPopulationGrammar.candidates do
    match AstronomicalPopulationEvidence.decideCandidate (AstronomicalPopulationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalPopulationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalPopulationEvidence.registration sourceHash),
    ("census",AstronomicalPopulationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalPopulationEvidence.closure decisions),
    ("controls",AstronomicalPopulationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
