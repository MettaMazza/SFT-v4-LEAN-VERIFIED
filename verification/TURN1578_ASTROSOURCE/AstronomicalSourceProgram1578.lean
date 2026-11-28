import SFT.AstronomyCosmology.AstronomicalSourceEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalSourceGrammar.candidates do
    match AstronomicalSourceEvidence.decideCandidate (AstronomicalSourceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalSourceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalSourceEvidence.registration sourceHash),
    ("census",AstronomicalSourceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalSourceEvidence.closure decisions),
    ("controls",AstronomicalSourceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
