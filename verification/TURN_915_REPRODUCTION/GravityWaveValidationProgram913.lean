import SFT.Physics.GravityWaveValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityWaveValidationGrammar.candidates do
    match GravityWaveValidationEvidence.decideCandidate (GravityWaveValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityWaveValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityWaveValidationEvidence.registration sourceHash),
    ("census",GravityWaveValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityWaveValidationEvidence.closure decisions),
    ("controls",GravityWaveValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
