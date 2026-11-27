import SFT.EarthEnvironment.EarthInteriorHeatTransportEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthInteriorHeatTransportGrammar.candidates do
    match EarthInteriorHeatTransportEvidence.decideCandidate (EarthInteriorHeatTransportEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthInteriorHeatTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthInteriorHeatTransportEvidence.registration sourceHash),
    ("census",EarthInteriorHeatTransportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthInteriorHeatTransportEvidence.closure decisions),
    ("controls",EarthInteriorHeatTransportEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
