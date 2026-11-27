import SFT.EarthEnvironment.EarthHydrologicCycleEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthHydrologicCycleGrammar.candidates do
    match EarthHydrologicCycleEvidence.decideCandidate (EarthHydrologicCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthHydrologicCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthHydrologicCycleEvidence.registration sourceHash),
    ("census",EarthHydrologicCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthHydrologicCycleEvidence.closure decisions),
    ("controls",EarthHydrologicCycleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
