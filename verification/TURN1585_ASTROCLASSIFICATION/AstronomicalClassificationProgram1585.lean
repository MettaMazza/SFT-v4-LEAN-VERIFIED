import SFT.AstronomyCosmology.AstronomicalClassificationEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalClassificationGrammar.candidates do
    match AstronomicalClassificationEvidence.decideCandidate (AstronomicalClassificationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalClassificationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalClassificationEvidence.registration sourceHash),
    ("census",AstronomicalClassificationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalClassificationEvidence.closure decisions),
    ("controls",AstronomicalClassificationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
