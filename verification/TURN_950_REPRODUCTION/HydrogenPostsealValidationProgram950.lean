import SFT.Physics.HydrogenPostsealValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HydrogenPostsealValidationGrammar.candidates do
    match HydrogenPostsealValidationEvidence.decideCandidate (HydrogenPostsealValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HydrogenPostsealValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HydrogenPostsealValidationEvidence.registration sourceHash),
    ("census",HydrogenPostsealValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HydrogenPostsealValidationEvidence.closure decisions),
    ("controls",HydrogenPostsealValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
