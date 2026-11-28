import SFT.EarthEnvironment.EarthPhosphorusCycleEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthPhosphorusCycleGrammar.candidates do
    match EarthPhosphorusCycleEvidence.decideCandidate (EarthPhosphorusCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthPhosphorusCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthPhosphorusCycleEvidence.registration sourceHash),
    ("census",EarthPhosphorusCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthPhosphorusCycleEvidence.closure decisions),
    ("controls",EarthPhosphorusCycleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
