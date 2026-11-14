import SFT.Physics.CubicPostsealValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CubicPostsealValidationGrammar.candidates do
    match CubicPostsealValidationEvidence.decideCandidate (CubicPostsealValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CubicPostsealValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CubicPostsealValidationEvidence.registration sourceHash),
    ("census",CubicPostsealValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CubicPostsealValidationEvidence.closure decisions),
    ("controls",CubicPostsealValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
