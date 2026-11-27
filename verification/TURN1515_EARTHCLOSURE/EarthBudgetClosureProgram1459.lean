import SFT.EarthEnvironment.EarthBudgetClosureEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthBudgetClosureGrammar.candidates do
    match EarthBudgetClosureEvidence.decideCandidate (EarthBudgetClosureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthBudgetClosureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthBudgetClosureEvidence.registration sourceHash),
    ("census",EarthBudgetClosureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthBudgetClosureEvidence.closure decisions),
    ("controls",EarthBudgetClosureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
