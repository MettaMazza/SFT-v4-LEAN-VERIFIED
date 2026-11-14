import SFT.Physics.GravityHorizonValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityHorizonValidationGrammar.candidates do
    match GravityHorizonValidationEvidence.decideCandidate (GravityHorizonValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityHorizonValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityHorizonValidationEvidence.registration sourceHash),
    ("census",GravityHorizonValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityHorizonValidationEvidence.closure decisions),
    ("controls",GravityHorizonValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
