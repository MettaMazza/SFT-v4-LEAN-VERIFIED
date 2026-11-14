import SFT.Physics.VacuumExtractionValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VacuumExtractionValidationGrammar.candidates do
    match VacuumExtractionValidationEvidence.decideCandidate (VacuumExtractionValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VacuumExtractionValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VacuumExtractionValidationEvidence.registration sourceHash),
    ("census",VacuumExtractionValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VacuumExtractionValidationEvidence.closure decisions),
    ("controls",VacuumExtractionValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
