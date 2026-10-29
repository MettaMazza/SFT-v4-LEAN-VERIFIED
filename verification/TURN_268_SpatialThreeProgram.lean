import SFT.Physics.SpatialThreeEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpatialThreeGrammar.candidates do
    match SpatialThreeEvidence.decideCandidate (SpatialThreeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpatialThreeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpatialThreeEvidence.registration sourceHash),
    ("census",SpatialThreeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpatialThreeEvidence.closure decisions),
    ("controls",SpatialThreeControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
