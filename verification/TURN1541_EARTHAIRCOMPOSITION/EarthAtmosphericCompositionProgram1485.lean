import SFT.EarthEnvironment.EarthAtmosphericCompositionEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAtmosphericCompositionGrammar.candidates do
    match EarthAtmosphericCompositionEvidence.decideCandidate (EarthAtmosphericCompositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAtmosphericCompositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAtmosphericCompositionEvidence.registration sourceHash),
    ("census",EarthAtmosphericCompositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAtmosphericCompositionEvidence.closure decisions),
    ("controls",EarthAtmosphericCompositionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
