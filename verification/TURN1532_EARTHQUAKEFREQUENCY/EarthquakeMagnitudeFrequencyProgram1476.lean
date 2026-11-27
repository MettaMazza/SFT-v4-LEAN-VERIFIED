import SFT.EarthEnvironment.EarthquakeMagnitudeFrequencyEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthquakeMagnitudeFrequencyGrammar.candidates do
    match EarthquakeMagnitudeFrequencyEvidence.decideCandidate (EarthquakeMagnitudeFrequencyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthquakeMagnitudeFrequencyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthquakeMagnitudeFrequencyEvidence.registration sourceHash),
    ("census",EarthquakeMagnitudeFrequencyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthquakeMagnitudeFrequencyEvidence.closure decisions),
    ("controls",EarthquakeMagnitudeFrequencyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
