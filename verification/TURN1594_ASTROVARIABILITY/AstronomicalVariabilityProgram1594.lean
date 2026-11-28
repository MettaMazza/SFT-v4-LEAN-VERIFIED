import SFT.AstronomyCosmology.AstronomicalVariabilityEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalVariabilityGrammar.candidates do
    match AstronomicalVariabilityEvidence.decideCandidate (AstronomicalVariabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalVariabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalVariabilityEvidence.registration sourceHash),
    ("census",AstronomicalVariabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalVariabilityEvidence.closure decisions),
    ("controls",AstronomicalVariabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
