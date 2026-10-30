import SFT.Physics.VacuumDensityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumDensityGrammar.candidates do
    match VacuumDensityEvidence.decideCandidate (VacuumDensityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumDensityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumDensityEvidence.registration sourceHash),
    ("census",VacuumDensityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumDensityEvidence.closure decisions),
    ("controls",VacuumDensityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
