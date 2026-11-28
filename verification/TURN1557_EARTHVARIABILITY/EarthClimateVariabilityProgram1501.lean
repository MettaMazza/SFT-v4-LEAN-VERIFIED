import SFT.EarthEnvironment.EarthClimateVariabilityEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthClimateVariabilityGrammar.candidates do
    match EarthClimateVariabilityEvidence.decideCandidate (EarthClimateVariabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthClimateVariabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthClimateVariabilityEvidence.registration sourceHash),
    ("census",EarthClimateVariabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthClimateVariabilityEvidence.closure decisions),
    ("controls",EarthClimateVariabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
