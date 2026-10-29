import SFT.Computation.OptimizationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OptimizationGrammar.candidates do
    match OptimizationEvidence.decideCandidate (OptimizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OptimizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OptimizationEvidence.registration sourceHash),
    ("census",OptimizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OptimizationEvidence.closure decisions),
    ("controls",OptimizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
