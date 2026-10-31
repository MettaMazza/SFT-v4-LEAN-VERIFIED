import SFT.Physics.MassEnergyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MassEnergyGrammar.candidates do
    match MassEnergyEvidence.decideCandidate (MassEnergyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MassEnergyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MassEnergyEvidence.registration sourceHash),
    ("census",MassEnergyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MassEnergyEvidence.closure decisions),
    ("controls",MassEnergyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
