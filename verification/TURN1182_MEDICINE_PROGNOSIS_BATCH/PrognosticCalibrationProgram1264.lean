import SFT.Medicine.PrognosticCalibrationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PrognosticCalibrationGrammar.candidates do
    match PrognosticCalibrationEvidence.decideCandidate (PrognosticCalibrationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PrognosticCalibrationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PrognosticCalibrationEvidence.registration sourceHash),
    ("census",PrognosticCalibrationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PrognosticCalibrationEvidence.closure decisions),
    ("controls",PrognosticCalibrationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
