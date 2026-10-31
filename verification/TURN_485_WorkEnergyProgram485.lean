import SFT.Physics.WorkEnergyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in WorkEnergyGrammar.candidates do
    match WorkEnergyEvidence.decideCandidate (WorkEnergyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match WorkEnergyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",WorkEnergyEvidence.registration sourceHash),
    ("census",WorkEnergyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",WorkEnergyEvidence.closure decisions),
    ("controls",WorkEnergyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
