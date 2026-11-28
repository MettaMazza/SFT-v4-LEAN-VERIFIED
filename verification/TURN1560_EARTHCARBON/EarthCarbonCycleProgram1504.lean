import SFT.EarthEnvironment.EarthCarbonCycleEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthCarbonCycleGrammar.candidates do
    match EarthCarbonCycleEvidence.decideCandidate (EarthCarbonCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthCarbonCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthCarbonCycleEvidence.registration sourceHash),
    ("census",EarthCarbonCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthCarbonCycleEvidence.closure decisions),
    ("controls",EarthCarbonCycleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
