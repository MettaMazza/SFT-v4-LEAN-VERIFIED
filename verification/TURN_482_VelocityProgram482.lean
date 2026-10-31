import SFT.Physics.VelocityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VelocityGrammar.candidates do
    match VelocityEvidence.decideCandidate (VelocityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VelocityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VelocityEvidence.registration sourceHash),
    ("census",VelocityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VelocityEvidence.closure decisions),
    ("controls",VelocityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
