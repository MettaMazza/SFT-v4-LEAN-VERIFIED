import SFT.Materials.FunctionalMagneticMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FunctionalMagneticMaterialGrammar.candidates do
    match FunctionalMagneticMaterialEvidence.decideCandidate (FunctionalMagneticMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FunctionalMagneticMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FunctionalMagneticMaterialEvidence.registration sourceHash),
    ("census",FunctionalMagneticMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FunctionalMagneticMaterialEvidence.closure decisions),
    ("controls",FunctionalMagneticMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
