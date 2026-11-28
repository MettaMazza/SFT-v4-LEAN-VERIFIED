import SFT.EarthEnvironment.EarthEnvironmentalTransportEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthEnvironmentalTransportGrammar.candidates do
    match EarthEnvironmentalTransportEvidence.decideCandidate (EarthEnvironmentalTransportEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthEnvironmentalTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthEnvironmentalTransportEvidence.registration sourceHash),
    ("census",EarthEnvironmentalTransportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthEnvironmentalTransportEvidence.closure decisions),
    ("controls",EarthEnvironmentalTransportEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
