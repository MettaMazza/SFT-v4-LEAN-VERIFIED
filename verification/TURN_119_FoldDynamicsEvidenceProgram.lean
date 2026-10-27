import SFT.Foundation.FoldDynamicsEvidence
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FoldDynamicsGrammar.candidates do
    match FoldDynamicsEvidence.decideCandidate (FoldDynamicsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FoldDynamicsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FoldDynamicsEvidence.registration sourceHash),
    ("census",FoldDynamicsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FoldDynamicsEvidence.closure decisions),
    ("controls",FoldDynamicsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
