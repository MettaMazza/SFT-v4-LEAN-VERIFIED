import SFT.Materials.CorrosionMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CorrosionMaterialGrammar.candidates do
    match CorrosionMaterialEvidence.decideCandidate (CorrosionMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CorrosionMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CorrosionMaterialEvidence.registration sourceHash),
    ("census",CorrosionMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CorrosionMaterialEvidence.closure decisions),
    ("controls",CorrosionMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
