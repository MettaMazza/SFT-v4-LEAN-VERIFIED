import SFT.Materials.PiezoMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PiezoMaterialGrammar.candidates do
    match PiezoMaterialEvidence.decideCandidate (PiezoMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PiezoMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PiezoMaterialEvidence.registration sourceHash),
    ("census",PiezoMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PiezoMaterialEvidence.closure decisions),
    ("controls",PiezoMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
