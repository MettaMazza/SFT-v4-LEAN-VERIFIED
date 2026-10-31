import SFT.Physics.VacuumPolarizationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumPolarizationGrammar.candidates do
    match VacuumPolarizationEvidence.decideCandidate (VacuumPolarizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumPolarizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumPolarizationEvidence.registration sourceHash),
    ("census",VacuumPolarizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumPolarizationEvidence.closure decisions),
    ("controls",VacuumPolarizationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
