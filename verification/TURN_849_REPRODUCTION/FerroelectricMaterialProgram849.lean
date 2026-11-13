import SFT.Materials.FerroelectricMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FerroelectricMaterialGrammar.candidates do
    match FerroelectricMaterialEvidence.decideCandidate (FerroelectricMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FerroelectricMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FerroelectricMaterialEvidence.registration sourceHash),
    ("census",FerroelectricMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FerroelectricMaterialEvidence.closure decisions),
    ("controls",FerroelectricMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
