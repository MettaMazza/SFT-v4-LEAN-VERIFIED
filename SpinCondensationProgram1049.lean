import SFT.Physics.SpinCondensationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpinCondensationGrammar.candidates do
    match SpinCondensationEvidence.decideCandidate (SpinCondensationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpinCondensationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpinCondensationEvidence.registration sourceHash),
    ("census",SpinCondensationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpinCondensationEvidence.closure decisions),
    ("controls",SpinCondensationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
