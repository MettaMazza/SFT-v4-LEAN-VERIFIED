import SFT.EarthEnvironment.EarthEnvironmentalAccumulationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthEnvironmentalAccumulationGrammar.candidates do
    match EarthEnvironmentalAccumulationEvidence.decideCandidate (EarthEnvironmentalAccumulationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthEnvironmentalAccumulationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthEnvironmentalAccumulationEvidence.registration sourceHash),
    ("census",EarthEnvironmentalAccumulationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthEnvironmentalAccumulationEvidence.closure decisions),
    ("controls",EarthEnvironmentalAccumulationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
