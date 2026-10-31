import SFT.Mathematics.SelfSimilarEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SelfSimilarGrammar.candidates do
    match SelfSimilarEvidence.decideCandidate (SelfSimilarEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SelfSimilarEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SelfSimilarEvidence.registration sourceHash),
    ("census",SelfSimilarEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SelfSimilarEvidence.closure decisions),
    ("controls",SelfSimilarControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
