import SFT.Physics.CriticalObservationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CriticalObservationGrammar.candidates do
    match CriticalObservationEvidence.decideCandidate (CriticalObservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CriticalObservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CriticalObservationEvidence.registration sourceHash),
    ("census",CriticalObservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CriticalObservationEvidence.closure decisions),
    ("controls",CriticalObservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
