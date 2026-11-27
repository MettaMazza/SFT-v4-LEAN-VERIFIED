import SFT.Chemistry.MetalClusterEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MetalClusterGrammar.candidates do
    match MetalClusterEvidence.decideCandidate (MetalClusterEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MetalClusterEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MetalClusterEvidence.registration sourceHash),
    ("census",MetalClusterEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MetalClusterEvidence.closure decisions),
    ("controls",MetalClusterEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
