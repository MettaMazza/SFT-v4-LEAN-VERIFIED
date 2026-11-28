import SFT.AstronomyCosmology.AstronomicalObserverEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalObserverGrammar.candidates do
    match AstronomicalObserverEvidence.decideCandidate (AstronomicalObserverEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalObserverEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalObserverEvidence.registration sourceHash),
    ("census",AstronomicalObserverEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalObserverEvidence.closure decisions),
    ("controls",AstronomicalObserverEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
