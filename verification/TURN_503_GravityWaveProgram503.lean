import SFT.Physics.GravityWaveEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityWaveGrammar.candidates do
    match GravityWaveEvidence.decideCandidate (GravityWaveEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityWaveEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityWaveEvidence.registration sourceHash),
    ("census",GravityWaveEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityWaveEvidence.closure decisions),
    ("controls",GravityWaveEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
