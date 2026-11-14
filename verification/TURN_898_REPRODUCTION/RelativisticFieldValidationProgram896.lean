import SFT.Physics.RelativisticFieldValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RelativisticFieldValidationGrammar.candidates do
    match RelativisticFieldValidationEvidence.decideCandidate (RelativisticFieldValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RelativisticFieldValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RelativisticFieldValidationEvidence.registration sourceHash),
    ("census",RelativisticFieldValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RelativisticFieldValidationEvidence.closure decisions),
    ("controls",RelativisticFieldValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
