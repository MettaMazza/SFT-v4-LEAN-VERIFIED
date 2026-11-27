import SFT.EarthEnvironment.EarthCryosphereEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthCryosphereGrammar.candidates do
    match EarthCryosphereEvidence.decideCandidate (EarthCryosphereEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthCryosphereEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthCryosphereEvidence.registration sourceHash),
    ("census",EarthCryosphereEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthCryosphereEvidence.closure decisions),
    ("controls",EarthCryosphereEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
