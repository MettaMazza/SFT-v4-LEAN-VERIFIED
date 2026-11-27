import SFT.EarthEnvironment.EarthTectonicMotionEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthTectonicMotionGrammar.candidates do
    match EarthTectonicMotionEvidence.decideCandidate (EarthTectonicMotionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthTectonicMotionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthTectonicMotionEvidence.registration sourceHash),
    ("census",EarthTectonicMotionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthTectonicMotionEvidence.closure decisions),
    ("controls",EarthTectonicMotionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
