import SFT.Physics.ConsistencyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConsistencyGrammar.candidates do
    match ConsistencyEvidence.decideCandidate (ConsistencyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConsistencyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConsistencyEvidence.registration sourceHash),
    ("census",ConsistencyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConsistencyEvidence.closure decisions),
    ("controls",ConsistencyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
