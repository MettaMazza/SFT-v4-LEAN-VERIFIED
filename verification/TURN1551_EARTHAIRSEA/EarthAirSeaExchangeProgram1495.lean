import SFT.EarthEnvironment.EarthAirSeaExchangeEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAirSeaExchangeGrammar.candidates do
    match EarthAirSeaExchangeEvidence.decideCandidate (EarthAirSeaExchangeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAirSeaExchangeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAirSeaExchangeEvidence.registration sourceHash),
    ("census",EarthAirSeaExchangeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAirSeaExchangeEvidence.closure decisions),
    ("controls",EarthAirSeaExchangeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
