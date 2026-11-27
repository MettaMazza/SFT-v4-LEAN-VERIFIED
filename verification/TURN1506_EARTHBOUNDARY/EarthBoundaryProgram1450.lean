import SFT.EarthEnvironment.EarthBoundaryEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthBoundaryGrammar.candidates do
    match EarthBoundaryEvidence.decideCandidate (EarthBoundaryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthBoundaryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthBoundaryEvidence.registration sourceHash),
    ("census",EarthBoundaryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthBoundaryEvidence.closure decisions),
    ("controls",EarthBoundaryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
