import SFT.EarthEnvironment.EarthCoastTideEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthCoastTideGrammar.candidates do
    match EarthCoastTideEvidence.decideCandidate (EarthCoastTideEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthCoastTideEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthCoastTideEvidence.registration sourceHash),
    ("census",EarthCoastTideEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthCoastTideEvidence.closure decisions),
    ("controls",EarthCoastTideEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
