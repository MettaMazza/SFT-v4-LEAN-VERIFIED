import SFT.Materials.CeramicMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CeramicMaterialGrammar.candidates do
    match CeramicMaterialEvidence.decideCandidate (CeramicMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CeramicMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CeramicMaterialEvidence.registration sourceHash),
    ("census",CeramicMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CeramicMaterialEvidence.closure decisions),
    ("controls",CeramicMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
