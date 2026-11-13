import SFT.Materials.HeatMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HeatMaterialGrammar.candidates do
    match HeatMaterialEvidence.decideCandidate (HeatMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HeatMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HeatMaterialEvidence.registration sourceHash),
    ("census",HeatMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HeatMaterialEvidence.closure decisions),
    ("controls",HeatMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
