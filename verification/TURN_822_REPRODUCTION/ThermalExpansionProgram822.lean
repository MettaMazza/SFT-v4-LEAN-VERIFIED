import SFT.Materials.ThermalExpansionEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermalExpansionGrammar.candidates do
    match ThermalExpansionEvidence.decideCandidate (ThermalExpansionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermalExpansionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermalExpansionEvidence.registration sourceHash),
    ("census",ThermalExpansionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermalExpansionEvidence.closure decisions),
    ("controls",ThermalExpansionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
