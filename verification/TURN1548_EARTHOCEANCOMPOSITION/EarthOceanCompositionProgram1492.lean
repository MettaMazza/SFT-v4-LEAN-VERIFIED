import SFT.EarthEnvironment.EarthOceanCompositionEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthOceanCompositionGrammar.candidates do
    match EarthOceanCompositionEvidence.decideCandidate (EarthOceanCompositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthOceanCompositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthOceanCompositionEvidence.registration sourceHash),
    ("census",EarthOceanCompositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthOceanCompositionEvidence.closure decisions),
    ("controls",EarthOceanCompositionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
