import SFT.EarthEnvironment.EarthClimateForcingEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthClimateForcingGrammar.candidates do
    match EarthClimateForcingEvidence.decideCandidate (EarthClimateForcingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthClimateForcingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthClimateForcingEvidence.registration sourceHash),
    ("census",EarthClimateForcingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthClimateForcingEvidence.closure decisions),
    ("controls",EarthClimateForcingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
