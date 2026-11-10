import SFT.Physics.InviscidEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InviscidGrammar.candidates do
    match InviscidEvidence.decideCandidate (InviscidEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InviscidEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InviscidEvidence.registration sourceHash),
    ("census",InviscidEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InviscidEvidence.closure decisions),
    ("controls",InviscidEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
