import SFT.Computation.LearningLimitsEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LearningLimitsGrammar.candidates do
    match LearningLimitsEvidence.decideCandidate (LearningLimitsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LearningLimitsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LearningLimitsEvidence.registration sourceHash),
    ("census",LearningLimitsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LearningLimitsEvidence.closure decisions),
    ("controls",LearningLimitsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
