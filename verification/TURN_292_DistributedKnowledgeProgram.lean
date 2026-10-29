import SFT.Computation.DistributedKnowledgeEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DistributedKnowledgeGrammar.candidates do
    match DistributedKnowledgeEvidence.decideCandidate (DistributedKnowledgeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DistributedKnowledgeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DistributedKnowledgeEvidence.registration sourceHash),
    ("census",DistributedKnowledgeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DistributedKnowledgeEvidence.closure decisions),
    ("controls",DistributedKnowledgeControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
