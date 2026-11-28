import SFT.EarthEnvironment.EarthEnvironmentalQualityEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthEnvironmentalQualityGrammar.candidates do
    match EarthEnvironmentalQualityEvidence.decideCandidate (EarthEnvironmentalQualityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthEnvironmentalQualityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthEnvironmentalQualityEvidence.registration sourceHash),
    ("census",EarthEnvironmentalQualityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthEnvironmentalQualityEvidence.closure decisions),
    ("controls",EarthEnvironmentalQualityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
