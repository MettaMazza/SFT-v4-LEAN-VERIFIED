import SFT.EarthEnvironment.EarthWeatherEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthWeatherGrammar.candidates do
    match EarthWeatherEvidence.decideCandidate (EarthWeatherEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthWeatherEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthWeatherEvidence.registration sourceHash),
    ("census",EarthWeatherEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthWeatherEvidence.closure decisions),
    ("controls",EarthWeatherEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
