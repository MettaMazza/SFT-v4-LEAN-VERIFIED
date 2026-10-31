import SFT.Physics.AngularMotionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AngularMotionGrammar.candidates do
    match AngularMotionEvidence.decideCandidate (AngularMotionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AngularMotionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AngularMotionEvidence.registration sourceHash),
    ("census",AngularMotionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AngularMotionEvidence.closure decisions),
    ("controls",AngularMotionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
