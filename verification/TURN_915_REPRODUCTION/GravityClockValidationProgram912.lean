import SFT.Physics.GravityClockValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityClockValidationGrammar.candidates do
    match GravityClockValidationEvidence.decideCandidate (GravityClockValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityClockValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityClockValidationEvidence.registration sourceHash),
    ("census",GravityClockValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityClockValidationEvidence.closure decisions),
    ("controls",GravityClockValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
