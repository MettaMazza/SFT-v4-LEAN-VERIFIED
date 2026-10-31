import SFT.Physics.ParticleAntiparticleEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ParticleAntiparticleGrammar.candidates do
    match ParticleAntiparticleEvidence.decideCandidate (ParticleAntiparticleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ParticleAntiparticleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ParticleAntiparticleEvidence.registration sourceHash),
    ("census",ParticleAntiparticleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ParticleAntiparticleEvidence.closure decisions),
    ("controls",ParticleAntiparticleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
