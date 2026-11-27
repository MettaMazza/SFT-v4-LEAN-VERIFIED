import SFT.EarthEnvironment.EarthEnergyBudgetEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthEnergyBudgetGrammar.candidates do
    match EarthEnergyBudgetEvidence.decideCandidate (EarthEnergyBudgetEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthEnergyBudgetEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthEnergyBudgetEvidence.registration sourceHash),
    ("census",EarthEnergyBudgetEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthEnergyBudgetEvidence.closure decisions),
    ("controls",EarthEnergyBudgetEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
