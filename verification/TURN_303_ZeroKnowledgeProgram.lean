import SFT.Computation.ZeroKnowledgeEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ZeroKnowledgeGrammar.candidates do
    match ZeroKnowledgeEvidence.decideCandidate (ZeroKnowledgeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ZeroKnowledgeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ZeroKnowledgeEvidence.registration sourceHash),
    ("census",ZeroKnowledgeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ZeroKnowledgeEvidence.closure decisions),
    ("controls",ZeroKnowledgeControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
