import SFT.Physics.VacuumFloorValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumFloorValidationGrammar.candidates do
    match VacuumFloorValidationEvidence.decideCandidate (VacuumFloorValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumFloorValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumFloorValidationEvidence.registration sourceHash),
    ("census",VacuumFloorValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumFloorValidationEvidence.closure decisions),
    ("controls",VacuumFloorValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
