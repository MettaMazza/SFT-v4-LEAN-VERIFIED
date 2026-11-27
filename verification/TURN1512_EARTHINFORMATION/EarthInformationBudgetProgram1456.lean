import SFT.EarthEnvironment.EarthInformationBudgetEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthInformationBudgetGrammar.candidates do
    match EarthInformationBudgetEvidence.decideCandidate (EarthInformationBudgetEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthInformationBudgetEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthInformationBudgetEvidence.registration sourceHash),
    ("census",EarthInformationBudgetEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthInformationBudgetEvidence.closure decisions),
    ("controls",EarthInformationBudgetEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
