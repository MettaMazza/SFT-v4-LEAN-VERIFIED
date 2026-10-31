import SFT.Physics.CosmoSpatialFlatnessEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoSpatialFlatnessGrammar.candidates do
    match CosmoSpatialFlatnessEvidence.decideCandidate (CosmoSpatialFlatnessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoSpatialFlatnessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoSpatialFlatnessEvidence.registration sourceHash),
    ("census",CosmoSpatialFlatnessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoSpatialFlatnessEvidence.closure decisions),
    ("controls",CosmoSpatialFlatnessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
