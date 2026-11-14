import SFT.Physics.VacuumCycleEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumCycleGrammar.candidates do
    match VacuumCycleEvidence.decideCandidate (VacuumCycleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumCycleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumCycleEvidence.registration sourceHash),
    ("census",VacuumCycleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumCycleEvidence.closure decisions),
    ("controls",VacuumCycleControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
