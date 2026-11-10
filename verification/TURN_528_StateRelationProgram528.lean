import SFT.Physics.StateRelationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StateRelationGrammar.candidates do
    match StateRelationEvidence.decideCandidate (StateRelationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StateRelationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StateRelationEvidence.registration sourceHash),
    ("census",StateRelationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StateRelationEvidence.closure decisions),
    ("controls",StateRelationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
