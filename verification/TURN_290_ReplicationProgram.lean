import SFT.Computation.ReplicationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ReplicationGrammar.candidates do
    match ReplicationEvidence.decideCandidate (ReplicationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ReplicationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ReplicationEvidence.registration sourceHash),
    ("census",ReplicationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ReplicationEvidence.closure decisions),
    ("controls",ReplicationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
