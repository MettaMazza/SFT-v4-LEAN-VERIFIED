import SFT.Materials.ThermoelectricMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermoelectricMaterialGrammar.candidates do
    match ThermoelectricMaterialEvidence.decideCandidate (ThermoelectricMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermoelectricMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermoelectricMaterialEvidence.registration sourceHash),
    ("census",ThermoelectricMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermoelectricMaterialEvidence.closure decisions),
    ("controls",ThermoelectricMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
