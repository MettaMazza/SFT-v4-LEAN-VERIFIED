import SFT.Computation.AdaptationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AdaptationGrammar.candidates do
    match AdaptationEvidence.decideCandidate (AdaptationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AdaptationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AdaptationEvidence.registration sourceHash),
    ("census",AdaptationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AdaptationEvidence.closure decisions),
    ("controls",AdaptationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
