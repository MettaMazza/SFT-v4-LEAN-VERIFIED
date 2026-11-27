import SFT.EarthEnvironment.EarthAtmosphericRadiativeBudgetEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAtmosphericRadiativeBudgetGrammar.candidates do
    match EarthAtmosphericRadiativeBudgetEvidence.decideCandidate (EarthAtmosphericRadiativeBudgetEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAtmosphericRadiativeBudgetEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAtmosphericRadiativeBudgetEvidence.registration sourceHash),
    ("census",EarthAtmosphericRadiativeBudgetEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAtmosphericRadiativeBudgetEvidence.closure decisions),
    ("controls",EarthAtmosphericRadiativeBudgetEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
