import SFT.EarthEnvironment.EarthClimateAttributionEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthClimateAttributionGrammar.candidates do
    match EarthClimateAttributionEvidence.decideCandidate (EarthClimateAttributionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthClimateAttributionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthClimateAttributionEvidence.registration sourceHash),
    ("census",EarthClimateAttributionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthClimateAttributionEvidence.closure decisions),
    ("controls",EarthClimateAttributionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
