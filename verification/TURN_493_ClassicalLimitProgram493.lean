import SFT.Physics.ClassicalLimitEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClassicalLimitGrammar.candidates do
    match ClassicalLimitEvidence.decideCandidate (ClassicalLimitEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClassicalLimitEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClassicalLimitEvidence.registration sourceHash),
    ("census",ClassicalLimitEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClassicalLimitEvidence.closure decisions),
    ("controls",ClassicalLimitEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
