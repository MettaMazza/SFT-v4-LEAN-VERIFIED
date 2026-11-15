import SFT.Physics.AccumulatedSeparationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  let tasks := AccumulatedSeparationGrammar.candidates.map fun c => Task.spawn (fun _ =>
    AccumulatedSeparationEvidence.decideCandidate (AccumulatedSeparationEvidence.generatedCandidateData c))
  for task in tasks do
    match task.get with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AccumulatedSeparationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AccumulatedSeparationEvidence.registration sourceHash),
    ("census",AccumulatedSeparationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AccumulatedSeparationEvidence.closure decisions),
    ("controls",AccumulatedSeparationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
