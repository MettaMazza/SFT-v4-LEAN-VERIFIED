import SFT.Computation.EvaluationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EvaluationGrammar.candidates do
    match EvaluationEvidence.decideCandidate (EvaluationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EvaluationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EvaluationEvidence.registration sourceHash),
    ("census",EvaluationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EvaluationEvidence.closure decisions),
    ("controls",EvaluationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
