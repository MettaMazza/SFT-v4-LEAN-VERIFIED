import SFT.EarthEnvironment.EarthBiodiversityEnvironmentEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthBiodiversityEnvironmentGrammar.candidates do
    match EarthBiodiversityEnvironmentEvidence.decideCandidate (EarthBiodiversityEnvironmentEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthBiodiversityEnvironmentEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthBiodiversityEnvironmentEvidence.registration sourceHash),
    ("census",EarthBiodiversityEnvironmentEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthBiodiversityEnvironmentEvidence.closure decisions),
    ("controls",EarthBiodiversityEnvironmentEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
