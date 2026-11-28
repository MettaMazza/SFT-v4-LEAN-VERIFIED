import SFT.AstronomyCosmology.AstrometricRadialMotionEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstrometricRadialMotionGrammar.candidates do
    match AstrometricRadialMotionEvidence.decideCandidate (AstrometricRadialMotionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstrometricRadialMotionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstrometricRadialMotionEvidence.registration sourceHash),
    ("census",AstrometricRadialMotionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstrometricRadialMotionEvidence.closure decisions),
    ("controls",AstrometricRadialMotionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
