import SFT.Physics.CollectiveObservationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CollectiveObservationGrammar.candidates do
    match CollectiveObservationEvidence.decideCandidate (CollectiveObservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CollectiveObservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CollectiveObservationEvidence.registration sourceHash),
    ("census",CollectiveObservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CollectiveObservationEvidence.closure decisions),
    ("controls",CollectiveObservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
