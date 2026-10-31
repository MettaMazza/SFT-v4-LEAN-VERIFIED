import SFT.Physics.CosmoBranchBoundaryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoBranchBoundaryGrammar.candidates do
    match CosmoBranchBoundaryEvidence.decideCandidate (CosmoBranchBoundaryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoBranchBoundaryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoBranchBoundaryEvidence.registration sourceHash),
    ("census",CosmoBranchBoundaryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoBranchBoundaryEvidence.closure decisions),
    ("controls",CosmoBranchBoundaryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
