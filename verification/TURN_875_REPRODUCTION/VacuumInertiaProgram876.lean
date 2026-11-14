import SFT.Physics.VacuumInertiaEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumInertiaGrammar.candidates do
    match VacuumInertiaEvidence.decideCandidate (VacuumInertiaEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumInertiaEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumInertiaEvidence.registration sourceHash),
    ("census",VacuumInertiaEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumInertiaEvidence.closure decisions),
    ("controls",VacuumInertiaControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
