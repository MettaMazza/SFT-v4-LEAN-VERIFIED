import SFT.EarthEnvironment.EarthBiosphereExchangeEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthBiosphereExchangeGrammar.candidates do
    match EarthBiosphereExchangeEvidence.decideCandidate (EarthBiosphereExchangeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthBiosphereExchangeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthBiosphereExchangeEvidence.registration sourceHash),
    ("census",EarthBiosphereExchangeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthBiosphereExchangeEvidence.closure decisions),
    ("controls",EarthBiosphereExchangeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
