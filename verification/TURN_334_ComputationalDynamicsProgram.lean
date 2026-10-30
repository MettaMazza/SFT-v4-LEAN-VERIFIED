import SFT.Computation.ComputationalDynamicsEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComputationalDynamicsGrammar.candidates do
    match ComputationalDynamicsEvidence.decideCandidate (ComputationalDynamicsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComputationalDynamicsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComputationalDynamicsEvidence.registration sourceHash),
    ("census",ComputationalDynamicsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComputationalDynamicsEvidence.closure decisions),
    ("controls",ComputationalDynamicsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
