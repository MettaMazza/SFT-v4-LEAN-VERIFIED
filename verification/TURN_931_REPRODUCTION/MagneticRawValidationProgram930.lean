import SFT.Physics.MagneticRawValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MagneticRawValidationGrammar.candidates do
    match MagneticRawValidationEvidence.decideCandidate (MagneticRawValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MagneticRawValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MagneticRawValidationEvidence.registration sourceHash),
    ("census",MagneticRawValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MagneticRawValidationEvidence.closure decisions),
    ("controls",MagneticRawValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
