import SFT.Physics.CosmoCompleteBudgetEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoCompleteBudgetGrammar.candidates do
    match CosmoCompleteBudgetEvidence.decideCandidate (CosmoCompleteBudgetEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoCompleteBudgetEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoCompleteBudgetEvidence.registration sourceHash),
    ("census",CosmoCompleteBudgetEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoCompleteBudgetEvidence.closure decisions),
    ("controls",CosmoCompleteBudgetControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
