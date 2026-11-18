import SFT.Medicine.DiagnosticClassificationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiagnosticClassificationGrammar.candidates do
    match DiagnosticClassificationEvidence.decideCandidate (DiagnosticClassificationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiagnosticClassificationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiagnosticClassificationEvidence.registration sourceHash),
    ("census",DiagnosticClassificationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiagnosticClassificationEvidence.closure decisions),
    ("controls",DiagnosticClassificationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
