import SFT.EarthEnvironment.EarthOceanCirculationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthOceanCirculationGrammar.candidates do
    match EarthOceanCirculationEvidence.decideCandidate (EarthOceanCirculationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthOceanCirculationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthOceanCirculationEvidence.registration sourceHash),
    ("census",EarthOceanCirculationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthOceanCirculationEvidence.closure decisions),
    ("controls",EarthOceanCirculationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
