import SFT.EarthEnvironment.EarthClimateEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthClimateGrammar.candidates do
    match EarthClimateEvidence.decideCandidate (EarthClimateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthClimateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthClimateEvidence.registration sourceHash),
    ("census",EarthClimateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthClimateEvidence.closure decisions),
    ("controls",EarthClimateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
