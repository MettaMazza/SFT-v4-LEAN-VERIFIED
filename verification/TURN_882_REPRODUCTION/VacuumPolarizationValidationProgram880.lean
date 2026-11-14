import SFT.Physics.VacuumPolarizationValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumPolarizationValidationGrammar.candidates do
    match VacuumPolarizationValidationEvidence.decideCandidate (VacuumPolarizationValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumPolarizationValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumPolarizationValidationEvidence.registration sourceHash),
    ("census",VacuumPolarizationValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumPolarizationValidationEvidence.closure decisions),
    ("controls",VacuumPolarizationValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
