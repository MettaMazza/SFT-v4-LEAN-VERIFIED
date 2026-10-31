import SFT.Physics.CosmoDistanceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoDistanceGrammar.candidates do
    match CosmoDistanceEvidence.decideCandidate (CosmoDistanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoDistanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoDistanceEvidence.registration sourceHash),
    ("census",CosmoDistanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoDistanceEvidence.closure decisions),
    ("controls",CosmoDistanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
