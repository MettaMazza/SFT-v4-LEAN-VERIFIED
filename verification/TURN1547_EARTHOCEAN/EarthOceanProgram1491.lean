import SFT.EarthEnvironment.EarthOceanEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthOceanGrammar.candidates do
    match EarthOceanEvidence.decideCandidate (EarthOceanEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthOceanEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthOceanEvidence.registration sourceHash),
    ("census",EarthOceanEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthOceanEvidence.closure decisions),
    ("controls",EarthOceanEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
