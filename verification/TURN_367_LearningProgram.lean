import SFT.QuantumComputation.LearningEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LearningGrammar.candidates do
    match LearningEvidence.decideCandidate (LearningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LearningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LearningEvidence.registration sourceHash),
    ("census",LearningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LearningEvidence.closure decisions),
    ("controls",LearningControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
