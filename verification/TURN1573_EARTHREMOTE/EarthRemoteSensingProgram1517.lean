import SFT.EarthEnvironment.EarthRemoteSensingEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthRemoteSensingGrammar.candidates do
    match EarthRemoteSensingEvidence.decideCandidate (EarthRemoteSensingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthRemoteSensingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthRemoteSensingEvidence.registration sourceHash),
    ("census",EarthRemoteSensingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthRemoteSensingEvidence.closure decisions),
    ("controls",EarthRemoteSensingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
