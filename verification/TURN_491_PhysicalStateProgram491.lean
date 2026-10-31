import SFT.Physics.PhysicalStateEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhysicalStateGrammar.candidates do
    match PhysicalStateEvidence.decideCandidate (PhysicalStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhysicalStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhysicalStateEvidence.registration sourceHash),
    ("census",PhysicalStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhysicalStateEvidence.closure decisions),
    ("controls",PhysicalStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
