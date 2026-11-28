import SFT.EarthEnvironment.EarthCoupledEcosystemEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthCoupledEcosystemGrammar.candidates do
    match EarthCoupledEcosystemEvidence.decideCandidate (EarthCoupledEcosystemEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthCoupledEcosystemEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthCoupledEcosystemEvidence.registration sourceHash),
    ("census",EarthCoupledEcosystemEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthCoupledEcosystemEvidence.closure decisions),
    ("controls",EarthCoupledEcosystemEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
