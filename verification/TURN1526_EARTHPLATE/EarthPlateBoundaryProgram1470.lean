import SFT.EarthEnvironment.EarthPlateBoundaryEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthPlateBoundaryGrammar.candidates do
    match EarthPlateBoundaryEvidence.decideCandidate (EarthPlateBoundaryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthPlateBoundaryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthPlateBoundaryEvidence.registration sourceHash),
    ("census",EarthPlateBoundaryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthPlateBoundaryEvidence.closure decisions),
    ("controls",EarthPlateBoundaryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
