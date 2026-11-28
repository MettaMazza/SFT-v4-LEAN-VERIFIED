import SFT.EarthEnvironment.EarthForecastValidationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthForecastValidationGrammar.candidates do
    match EarthForecastValidationEvidence.decideCandidate (EarthForecastValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthForecastValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthForecastValidationEvidence.registration sourceHash),
    ("census",EarthForecastValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthForecastValidationEvidence.closure decisions),
    ("controls",EarthForecastValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
