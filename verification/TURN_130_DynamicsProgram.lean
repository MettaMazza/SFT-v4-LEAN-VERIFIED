import SFT.Mathematics.DynamicsEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DynamicsGrammar.candidates do
    match DynamicsEvidence.decideCandidate (DynamicsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DynamicsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DynamicsEvidence.registration sourceHash),
    ("census",DynamicsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DynamicsEvidence.closure decisions),
    ("controls",DynamicsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
