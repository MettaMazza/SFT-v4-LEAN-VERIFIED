import SFT.Computation.LearningOptimizationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LearningOptimizationGrammar.candidates do
    match LearningOptimizationEvidence.decideCandidate (LearningOptimizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LearningOptimizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LearningOptimizationEvidence.registration sourceHash),
    ("census",LearningOptimizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LearningOptimizationEvidence.closure decisions),
    ("controls",LearningOptimizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
