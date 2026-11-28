import SFT.EarthEnvironment.EarthPollutantIdentityEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthPollutantIdentityGrammar.candidates do
    match EarthPollutantIdentityEvidence.decideCandidate (EarthPollutantIdentityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthPollutantIdentityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthPollutantIdentityEvidence.registration sourceHash),
    ("census",EarthPollutantIdentityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthPollutantIdentityEvidence.closure decisions),
    ("controls",EarthPollutantIdentityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
