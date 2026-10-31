import SFT.Physics.AccelerationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AccelerationGrammar.candidates do
    match AccelerationEvidence.decideCandidate (AccelerationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AccelerationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AccelerationEvidence.registration sourceHash),
    ("census",AccelerationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AccelerationEvidence.closure decisions),
    ("controls",AccelerationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
