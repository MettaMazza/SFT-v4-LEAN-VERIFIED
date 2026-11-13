import SFT.Materials.AnisotropyMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AnisotropyMaterialGrammar.candidates do
    match AnisotropyMaterialEvidence.decideCandidate (AnisotropyMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AnisotropyMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AnisotropyMaterialEvidence.registration sourceHash),
    ("census",AnisotropyMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AnisotropyMaterialEvidence.closure decisions),
    ("controls",AnisotropyMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
