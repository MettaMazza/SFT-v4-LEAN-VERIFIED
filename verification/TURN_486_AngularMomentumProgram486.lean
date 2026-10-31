import SFT.Physics.AngularMomentumEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AngularMomentumGrammar.candidates do
    match AngularMomentumEvidence.decideCandidate (AngularMomentumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AngularMomentumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AngularMomentumEvidence.registration sourceHash),
    ("census",AngularMomentumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AngularMomentumEvidence.closure decisions),
    ("controls",AngularMomentumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
