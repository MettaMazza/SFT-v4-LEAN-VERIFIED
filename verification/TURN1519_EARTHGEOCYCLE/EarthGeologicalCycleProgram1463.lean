import SFT.EarthEnvironment.EarthGeologicalCycleEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthGeologicalCycleGrammar.candidates do
    match EarthGeologicalCycleEvidence.decideCandidate (EarthGeologicalCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthGeologicalCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthGeologicalCycleEvidence.registration sourceHash),
    ("census",EarthGeologicalCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthGeologicalCycleEvidence.closure decisions),
    ("controls",EarthGeologicalCycleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
