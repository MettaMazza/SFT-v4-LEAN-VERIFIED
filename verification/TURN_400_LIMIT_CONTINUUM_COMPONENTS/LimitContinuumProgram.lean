import SFT.Mathematics.LimitContinuumEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LimitContinuumGrammar.candidates do
    match LimitContinuumEvidence.decideCandidate (LimitContinuumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LimitContinuumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LimitContinuumEvidence.registration sourceHash),
    ("census",LimitContinuumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LimitContinuumEvidence.closure decisions),
    ("controls",LimitContinuumControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
