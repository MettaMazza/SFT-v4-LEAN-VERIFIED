import SFT.Materials.PolymerMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PolymerMaterialGrammar.candidates do
    match PolymerMaterialEvidence.decideCandidate (PolymerMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PolymerMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PolymerMaterialEvidence.registration sourceHash),
    ("census",PolymerMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PolymerMaterialEvidence.closure decisions),
    ("controls",PolymerMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
