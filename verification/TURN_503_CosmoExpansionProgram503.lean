import SFT.Physics.CosmoExpansionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoExpansionGrammar.candidates do
    match CosmoExpansionEvidence.decideCandidate (CosmoExpansionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoExpansionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoExpansionEvidence.registration sourceHash),
    ("census",CosmoExpansionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoExpansionEvidence.closure decisions),
    ("controls",CosmoExpansionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
