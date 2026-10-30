import SFT.Computation.ClassicalLearningEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClassicalLearningGrammar.candidates do
    match ClassicalLearningEvidence.decideCandidate (ClassicalLearningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClassicalLearningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClassicalLearningEvidence.registration sourceHash),
    ("census",ClassicalLearningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClassicalLearningEvidence.closure decisions),
    ("controls",ClassicalLearningControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
