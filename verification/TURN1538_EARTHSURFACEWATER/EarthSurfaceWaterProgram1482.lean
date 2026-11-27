import SFT.EarthEnvironment.EarthSurfaceWaterEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthSurfaceWaterGrammar.candidates do
    match EarthSurfaceWaterEvidence.decideCandidate (EarthSurfaceWaterEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthSurfaceWaterEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthSurfaceWaterEvidence.registration sourceHash),
    ("census",EarthSurfaceWaterEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthSurfaceWaterEvidence.closure decisions),
    ("controls",EarthSurfaceWaterEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
