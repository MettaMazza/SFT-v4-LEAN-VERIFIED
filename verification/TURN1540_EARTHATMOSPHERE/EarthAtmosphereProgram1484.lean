import SFT.EarthEnvironment.EarthAtmosphereEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAtmosphereGrammar.candidates do
    match EarthAtmosphereEvidence.decideCandidate (EarthAtmosphereEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAtmosphereEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAtmosphereEvidence.registration sourceHash),
    ("census",EarthAtmosphereEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAtmosphereEvidence.closure decisions),
    ("controls",EarthAtmosphereEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
