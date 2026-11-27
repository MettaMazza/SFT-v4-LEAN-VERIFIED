import SFT.EarthEnvironment.EarthAtmosphericCirculationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAtmosphericCirculationGrammar.candidates do
    match EarthAtmosphericCirculationEvidence.decideCandidate (EarthAtmosphericCirculationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAtmosphericCirculationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAtmosphericCirculationEvidence.registration sourceHash),
    ("census",EarthAtmosphericCirculationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAtmosphericCirculationEvidence.closure decisions),
    ("controls",EarthAtmosphericCirculationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
