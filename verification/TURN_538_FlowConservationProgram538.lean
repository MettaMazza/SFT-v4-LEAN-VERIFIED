import SFT.Physics.FlowConservationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FlowConservationGrammar.candidates do
    match FlowConservationEvidence.decideCandidate (FlowConservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FlowConservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FlowConservationEvidence.registration sourceHash),
    ("census",FlowConservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FlowConservationEvidence.closure decisions),
    ("controls",FlowConservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
