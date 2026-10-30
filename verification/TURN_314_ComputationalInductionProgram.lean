import SFT.Computation.ComputationalInductionEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComputationalInductionGrammar.candidates do
    match ComputationalInductionEvidence.decideCandidate (ComputationalInductionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComputationalInductionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComputationalInductionEvidence.registration sourceHash),
    ("census",ComputationalInductionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComputationalInductionEvidence.closure decisions),
    ("controls",ComputationalInductionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
