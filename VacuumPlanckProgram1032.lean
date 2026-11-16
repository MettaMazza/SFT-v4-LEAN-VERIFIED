import SFT.Physics.VacuumPlanckEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumPlanckGrammar.candidates do
    match VacuumPlanckEvidence.decideCandidate (VacuumPlanckEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumPlanckEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumPlanckEvidence.registration sourceHash),
    ("census",VacuumPlanckEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumPlanckEvidence.closure decisions),
    ("controls",VacuumPlanckEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
