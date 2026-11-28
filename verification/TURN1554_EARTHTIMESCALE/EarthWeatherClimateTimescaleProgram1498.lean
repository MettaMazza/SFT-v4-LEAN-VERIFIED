import SFT.EarthEnvironment.EarthWeatherClimateTimescaleEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthWeatherClimateTimescaleGrammar.candidates do
    match EarthWeatherClimateTimescaleEvidence.decideCandidate (EarthWeatherClimateTimescaleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthWeatherClimateTimescaleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthWeatherClimateTimescaleEvidence.registration sourceHash),
    ("census",EarthWeatherClimateTimescaleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthWeatherClimateTimescaleEvidence.closure decisions),
    ("controls",EarthWeatherClimateTimescaleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
