import SFT.EarthEnvironment.EarthSystemTippingEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthSystemTippingGrammar.candidates do
    match EarthSystemTippingEvidence.decideCandidate (EarthSystemTippingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthSystemTippingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthSystemTippingEvidence.registration sourceHash),
    ("census",EarthSystemTippingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthSystemTippingEvidence.closure decisions),
    ("controls",EarthSystemTippingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
