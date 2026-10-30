import SFT.Physics.VacuumFloorEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumFloorGrammar.candidates do
    match VacuumFloorEvidence.decideCandidate (VacuumFloorEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumFloorEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumFloorEvidence.registration sourceHash),
    ("census",VacuumFloorEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumFloorEvidence.closure decisions),
    ("controls",VacuumFloorControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
