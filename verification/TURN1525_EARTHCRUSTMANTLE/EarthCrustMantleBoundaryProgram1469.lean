import SFT.EarthEnvironment.EarthCrustMantleBoundaryEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthCrustMantleBoundaryGrammar.candidates do
    match EarthCrustMantleBoundaryEvidence.decideCandidate (EarthCrustMantleBoundaryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthCrustMantleBoundaryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthCrustMantleBoundaryEvidence.registration sourceHash),
    ("census",EarthCrustMantleBoundaryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthCrustMantleBoundaryEvidence.closure decisions),
    ("controls",EarthCrustMantleBoundaryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
