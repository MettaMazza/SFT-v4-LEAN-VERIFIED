import SFT.Materials.PhaseMapMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhaseMapMaterialGrammar.candidates do
    match PhaseMapMaterialEvidence.decideCandidate (PhaseMapMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhaseMapMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhaseMapMaterialEvidence.registration sourceHash),
    ("census",PhaseMapMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhaseMapMaterialEvidence.closure decisions),
    ("controls",PhaseMapMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
