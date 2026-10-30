import SFT.QuantumComputation.ClassicalCorrespondenceEvidence
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClassicalCorrespondenceGrammar.candidates do
    match ClassicalCorrespondenceEvidence.decideCandidate (ClassicalCorrespondenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClassicalCorrespondenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClassicalCorrespondenceEvidence.registration sourceHash),
    ("census",ClassicalCorrespondenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClassicalCorrespondenceEvidence.closure decisions),
    ("controls",ClassicalCorrespondenceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
