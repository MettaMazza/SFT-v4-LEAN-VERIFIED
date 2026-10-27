import SFT
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasurementGrammar.candidates do
    match MeasurementEvidence.decideCandidate (MeasurementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasurementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasurementEvidence.registration sourceHash),
    ("census",MeasurementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasurementEvidence.closure decisions),
    ("controls",MeasurementControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
