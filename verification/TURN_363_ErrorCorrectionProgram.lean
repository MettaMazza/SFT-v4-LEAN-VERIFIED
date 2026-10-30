import SFT.QuantumComputation.ErrorCorrectionEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ErrorCorrectionGrammar.candidates do
    match ErrorCorrectionEvidence.decideCandidate (ErrorCorrectionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ErrorCorrectionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ErrorCorrectionEvidence.registration sourceHash),
    ("census",ErrorCorrectionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ErrorCorrectionEvidence.closure decisions),
    ("controls",ErrorCorrectionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
