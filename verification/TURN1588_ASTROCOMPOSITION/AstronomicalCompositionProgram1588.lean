import SFT.AstronomyCosmology.AstronomicalCompositionEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalCompositionGrammar.candidates do
    match AstronomicalCompositionEvidence.decideCandidate (AstronomicalCompositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalCompositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalCompositionEvidence.registration sourceHash),
    ("census",AstronomicalCompositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalCompositionEvidence.closure decisions),
    ("controls",AstronomicalCompositionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
