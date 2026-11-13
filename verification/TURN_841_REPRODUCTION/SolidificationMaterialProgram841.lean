import SFT.Materials.SolidificationMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SolidificationMaterialGrammar.candidates do
    match SolidificationMaterialEvidence.decideCandidate (SolidificationMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SolidificationMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SolidificationMaterialEvidence.registration sourceHash),
    ("census",SolidificationMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SolidificationMaterialEvidence.closure decisions),
    ("controls",SolidificationMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
