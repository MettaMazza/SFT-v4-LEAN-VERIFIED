import SFT.Physics.ParticleSpectrumEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ParticleSpectrumGrammar.candidates do
    match ParticleSpectrumEvidence.decideCandidate (ParticleSpectrumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ParticleSpectrumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ParticleSpectrumEvidence.registration sourceHash),
    ("census",ParticleSpectrumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ParticleSpectrumEvidence.closure decisions),
    ("controls",ParticleSpectrumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
