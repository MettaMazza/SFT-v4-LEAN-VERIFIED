import SFT.Physics.ThermalObservationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermalObservationGrammar.candidates do
    match ThermalObservationEvidence.decideCandidate (ThermalObservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermalObservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermalObservationEvidence.registration sourceHash),
    ("census",ThermalObservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermalObservationEvidence.closure decisions),
    ("controls",ThermalObservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
