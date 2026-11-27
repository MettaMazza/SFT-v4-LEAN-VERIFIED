import SFT.EarthEnvironment.EarthRuptureEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthRuptureGrammar.candidates do
    match EarthRuptureEvidence.decideCandidate (EarthRuptureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthRuptureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthRuptureEvidence.registration sourceHash),
    ("census",EarthRuptureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthRuptureEvidence.closure decisions),
    ("controls",EarthRuptureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
