import SFT.Medicine.DifferentialDiagnosisEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DifferentialDiagnosisGrammar.candidates do
    match DifferentialDiagnosisEvidence.decideCandidate (DifferentialDiagnosisEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DifferentialDiagnosisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DifferentialDiagnosisEvidence.registration sourceHash),
    ("census",DifferentialDiagnosisEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DifferentialDiagnosisEvidence.closure decisions),
    ("controls",DifferentialDiagnosisEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
