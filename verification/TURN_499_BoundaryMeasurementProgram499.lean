import SFT.Physics.BoundaryMeasurementEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BoundaryMeasurementGrammar.candidates do
    match BoundaryMeasurementEvidence.decideCandidate (BoundaryMeasurementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BoundaryMeasurementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BoundaryMeasurementEvidence.registration sourceHash),
    ("census",BoundaryMeasurementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BoundaryMeasurementEvidence.closure decisions),
    ("controls",BoundaryMeasurementControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
