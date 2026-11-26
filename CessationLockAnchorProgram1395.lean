import SFT.Consciousness.CessationLockAnchorEvidence
open SFT.Host.Canonical SFT.Consciousness

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CessationLockAnchorGrammar.candidates do
    match CessationLockAnchorEvidence.decideCandidate (CessationLockAnchorEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CessationLockAnchorEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CessationLockAnchorEvidence.registration sourceHash),
    ("census",CessationLockAnchorEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CessationLockAnchorEvidence.closure decisions),
    ("controls",CessationLockAnchorEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
