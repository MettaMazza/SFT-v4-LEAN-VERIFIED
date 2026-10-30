import SFT.Physics.VacuumOddEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumOddGrammar.candidates do
    match VacuumOddEvidence.decideCandidate (VacuumOddEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumOddEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumOddEvidence.registration sourceHash),
    ("census",VacuumOddEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumOddEvidence.closure decisions),
    ("controls",VacuumOddControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
