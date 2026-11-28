import SFT.EarthEnvironment.EarthProxyReconstructionEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthProxyReconstructionGrammar.candidates do
    match EarthProxyReconstructionEvidence.decideCandidate (EarthProxyReconstructionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthProxyReconstructionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthProxyReconstructionEvidence.registration sourceHash),
    ("census",EarthProxyReconstructionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthProxyReconstructionEvidence.closure decisions),
    ("controls",EarthProxyReconstructionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
