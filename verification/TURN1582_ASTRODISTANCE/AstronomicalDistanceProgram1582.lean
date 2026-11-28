import SFT.AstronomyCosmology.AstronomicalDistanceEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalDistanceGrammar.candidates do
    match AstronomicalDistanceEvidence.decideCandidate (AstronomicalDistanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalDistanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalDistanceEvidence.registration sourceHash),
    ("census",AstronomicalDistanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalDistanceEvidence.closure decisions),
    ("controls",AstronomicalDistanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
