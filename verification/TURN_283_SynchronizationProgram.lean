import SFT.Computation.SynchronizationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SynchronizationGrammar.candidates do
    match SynchronizationEvidence.decideCandidate (SynchronizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SynchronizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SynchronizationEvidence.registration sourceHash),
    ("census",SynchronizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SynchronizationEvidence.closure decisions),
    ("controls",SynchronizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
