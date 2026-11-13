import SFT.Mathematics.AlgebraicBalanceEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AlgebraicBalanceGrammar.candidates do
    match AlgebraicBalanceEvidence.decideCandidate (AlgebraicBalanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AlgebraicBalanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AlgebraicBalanceEvidence.registration sourceHash),
    ("census",AlgebraicBalanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AlgebraicBalanceEvidence.closure decisions),
    ("controls",AlgebraicBalanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
