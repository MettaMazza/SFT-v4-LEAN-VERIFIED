import SFT.EarthEnvironment.EarthGroundwaterEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthGroundwaterGrammar.candidates do
    match EarthGroundwaterEvidence.decideCandidate (EarthGroundwaterEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthGroundwaterEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthGroundwaterEvidence.registration sourceHash),
    ("census",EarthGroundwaterEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthGroundwaterEvidence.closure decisions),
    ("controls",EarthGroundwaterEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
