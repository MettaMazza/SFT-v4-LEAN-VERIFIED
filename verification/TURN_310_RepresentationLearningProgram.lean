import SFT.Computation.RepresentationLearningEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RepresentationLearningGrammar.candidates do
    match RepresentationLearningEvidence.decideCandidate (RepresentationLearningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RepresentationLearningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RepresentationLearningEvidence.registration sourceHash),
    ("census",RepresentationLearningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RepresentationLearningEvidence.closure decisions),
    ("controls",RepresentationLearningControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
