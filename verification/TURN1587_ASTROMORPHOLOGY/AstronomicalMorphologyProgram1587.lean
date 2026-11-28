import SFT.AstronomyCosmology.AstronomicalMorphologyEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalMorphologyGrammar.candidates do
    match AstronomicalMorphologyEvidence.decideCandidate (AstronomicalMorphologyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalMorphologyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalMorphologyEvidence.registration sourceHash),
    ("census",AstronomicalMorphologyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalMorphologyEvidence.closure decisions),
    ("controls",AstronomicalMorphologyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
