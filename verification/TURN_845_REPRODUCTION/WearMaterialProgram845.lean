import SFT.Materials.WearMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in WearMaterialGrammar.candidates do
    match WearMaterialEvidence.decideCandidate (WearMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match WearMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",WearMaterialEvidence.registration sourceHash),
    ("census",WearMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",WearMaterialEvidence.closure decisions),
    ("controls",WearMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
