import SFT.EarthEnvironment.EarthSeismicWaveEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthSeismicWaveGrammar.candidates do
    match EarthSeismicWaveEvidence.decideCandidate (EarthSeismicWaveEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthSeismicWaveEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthSeismicWaveEvidence.registration sourceHash),
    ("census",EarthSeismicWaveEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthSeismicWaveEvidence.closure decisions),
    ("controls",EarthSeismicWaveEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
