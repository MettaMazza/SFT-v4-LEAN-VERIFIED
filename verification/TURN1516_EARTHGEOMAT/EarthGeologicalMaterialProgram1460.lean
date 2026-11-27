import SFT.EarthEnvironment.EarthGeologicalMaterialEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthGeologicalMaterialGrammar.candidates do
    match EarthGeologicalMaterialEvidence.decideCandidate (EarthGeologicalMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthGeologicalMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthGeologicalMaterialEvidence.registration sourceHash),
    ("census",EarthGeologicalMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthGeologicalMaterialEvidence.closure decisions),
    ("controls",EarthGeologicalMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
