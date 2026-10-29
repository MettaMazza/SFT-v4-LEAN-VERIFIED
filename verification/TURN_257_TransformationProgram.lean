import SFT.Computation.TransformationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TransformationGrammar.candidates do
    match TransformationEvidence.decideCandidate (TransformationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TransformationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TransformationEvidence.registration sourceHash),
    ("census",TransformationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TransformationEvidence.closure decisions),
    ("controls",TransformationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
