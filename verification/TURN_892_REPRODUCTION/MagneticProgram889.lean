import SFT.Physics.MagneticCorrectionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MagneticCorrectionGrammar.candidates do
    match MagneticCorrectionEvidence.decideCandidate (MagneticCorrectionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MagneticCorrectionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MagneticCorrectionEvidence.registration sourceHash),
    ("census",MagneticCorrectionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MagneticCorrectionEvidence.closure decisions),
    ("controls",MagneticCorrectionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
