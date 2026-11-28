import SFT.EarthEnvironment.EarthOceanStratificationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthOceanStratificationGrammar.candidates do
    match EarthOceanStratificationEvidence.decideCandidate (EarthOceanStratificationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthOceanStratificationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthOceanStratificationEvidence.registration sourceHash),
    ("census",EarthOceanStratificationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthOceanStratificationEvidence.closure decisions),
    ("controls",EarthOceanStratificationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
