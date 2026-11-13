import SFT.Materials.ThermalConductionEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermalConductionGrammar.candidates do
    match ThermalConductionEvidence.decideCandidate (ThermalConductionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermalConductionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermalConductionEvidence.registration sourceHash),
    ("census",ThermalConductionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermalConductionEvidence.closure decisions),
    ("controls",ThermalConductionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
