import SFT.Computation.AlgebraicGeometricEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AlgebraicGeometricGrammar.candidates do
    match AlgebraicGeometricEvidence.decideCandidate (AlgebraicGeometricEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AlgebraicGeometricEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AlgebraicGeometricEvidence.registration sourceHash),
    ("census",AlgebraicGeometricEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AlgebraicGeometricEvidence.closure decisions),
    ("controls",AlgebraicGeometricControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
