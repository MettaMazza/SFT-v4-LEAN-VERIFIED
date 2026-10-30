import SFT.Computation.MultiAgentEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MultiAgentGrammar.candidates do
    match MultiAgentEvidence.decideCandidate (MultiAgentEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MultiAgentEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MultiAgentEvidence.registration sourceHash),
    ("census",MultiAgentEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MultiAgentEvidence.closure decisions),
    ("controls",MultiAgentControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
