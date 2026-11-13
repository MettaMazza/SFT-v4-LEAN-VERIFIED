import SFT.Materials.SinteringMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SinteringMaterialGrammar.candidates do
    match SinteringMaterialEvidence.decideCandidate (SinteringMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SinteringMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SinteringMaterialEvidence.registration sourceHash),
    ("census",SinteringMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SinteringMaterialEvidence.closure decisions),
    ("controls",SinteringMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
