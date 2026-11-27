import SFT.EarthEnvironment.EarthMatterBudgetEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthMatterBudgetGrammar.candidates do
    match EarthMatterBudgetEvidence.decideCandidate (EarthMatterBudgetEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthMatterBudgetEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthMatterBudgetEvidence.registration sourceHash),
    ("census",EarthMatterBudgetEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthMatterBudgetEvidence.closure decisions),
    ("controls",EarthMatterBudgetEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
