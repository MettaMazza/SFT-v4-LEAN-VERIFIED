import SFT.Computation.BoundsEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BoundsGrammar.candidates do
    match BoundsEvidence.decideCandidate (BoundsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BoundsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BoundsEvidence.registration sourceHash),
    ("census",BoundsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BoundsEvidence.closure decisions),
    ("controls",BoundsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
