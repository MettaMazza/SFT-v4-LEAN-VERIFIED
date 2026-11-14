import SFT.Physics.ProtonPrecisionValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ProtonPrecisionValidationGrammar.candidates do
    match ProtonPrecisionValidationEvidence.decideCandidate (ProtonPrecisionValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ProtonPrecisionValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ProtonPrecisionValidationEvidence.registration sourceHash),
    ("census",ProtonPrecisionValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ProtonPrecisionValidationEvidence.closure decisions),
    ("controls",ProtonPrecisionValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
