import SFT.EarthEnvironment.EarthMoistureCloudEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthMoistureCloudGrammar.candidates do
    match EarthMoistureCloudEvidence.decideCandidate (EarthMoistureCloudEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthMoistureCloudEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthMoistureCloudEvidence.registration sourceHash),
    ("census",EarthMoistureCloudEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthMoistureCloudEvidence.closure decisions),
    ("controls",EarthMoistureCloudEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
