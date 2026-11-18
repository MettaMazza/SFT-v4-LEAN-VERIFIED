import SFT.Medicine.DiagnosticAccuracyEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiagnosticAccuracyGrammar.candidates do
    match DiagnosticAccuracyEvidence.decideCandidate (DiagnosticAccuracyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiagnosticAccuracyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiagnosticAccuracyEvidence.registration sourceHash),
    ("census",DiagnosticAccuracyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiagnosticAccuracyEvidence.closure decisions),
    ("controls",DiagnosticAccuracyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
