import SFT.Physics.CalibrationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CalibrationGrammar.candidates do
    match CalibrationEvidence.decideCandidate (CalibrationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CalibrationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CalibrationEvidence.registration sourceHash),
    ("census",CalibrationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CalibrationEvidence.closure decisions),
    ("controls",CalibrationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
