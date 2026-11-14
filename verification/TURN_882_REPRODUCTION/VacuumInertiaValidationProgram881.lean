import SFT.Physics.VacuumInertiaValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumInertiaValidationGrammar.candidates do
    match VacuumInertiaValidationEvidence.decideCandidate (VacuumInertiaValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumInertiaValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumInertiaValidationEvidence.registration sourceHash),
    ("census",VacuumInertiaValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumInertiaValidationEvidence.closure decisions),
    ("controls",VacuumInertiaValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
