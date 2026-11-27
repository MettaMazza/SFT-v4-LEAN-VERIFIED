import SFT.EarthEnvironment.EarthGeologicalLayerEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthGeologicalLayerGrammar.candidates do
    match EarthGeologicalLayerEvidence.decideCandidate (EarthGeologicalLayerEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthGeologicalLayerEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthGeologicalLayerEvidence.registration sourceHash),
    ("census",EarthGeologicalLayerEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthGeologicalLayerEvidence.closure decisions),
    ("controls",EarthGeologicalLayerEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
