import SFT.EarthEnvironment.EarthInternalHeatEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthInternalHeatGrammar.candidates do
    match EarthInternalHeatEvidence.decideCandidate (EarthInternalHeatEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthInternalHeatEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthInternalHeatEvidence.registration sourceHash),
    ("census",EarthInternalHeatEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthInternalHeatEvidence.closure decisions),
    ("controls",EarthInternalHeatEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
