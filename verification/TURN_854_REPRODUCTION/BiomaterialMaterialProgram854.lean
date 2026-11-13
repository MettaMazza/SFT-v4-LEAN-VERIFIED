import SFT.Materials.BiomaterialMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BiomaterialMaterialGrammar.candidates do
    match BiomaterialMaterialEvidence.decideCandidate (BiomaterialMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BiomaterialMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BiomaterialMaterialEvidence.registration sourceHash),
    ("census",BiomaterialMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BiomaterialMaterialEvidence.closure decisions),
    ("controls",BiomaterialMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
