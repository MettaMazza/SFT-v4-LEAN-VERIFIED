import SFT
open SFT.Host.Canonical SFT.Foundation

def emitFormEnforcement (sourceHash : String) : IO Unit := do
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FormEnforcementGrammar.candidates do
    match FormEnforcementEvidence.decideCandidate (FormEnforcementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FormEnforcementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FormEnforcementEvidence.registration sourceHash),
    ("census",FormEnforcementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FormEnforcementEvidence.closure decisions),
    ("controls",FormEnforcementControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))

def emitMeasurement (sourceHash : String) : IO Unit := do
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

def main (args : List String) : IO Unit := do
  match args with
  | [formHash,measurementHash] =>
    emitFormEnforcement formHash
    emitMeasurement measurementHash
  | _ => throw (IO.userError "Pass both pinned source hashes")
