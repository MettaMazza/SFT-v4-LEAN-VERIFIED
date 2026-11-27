import SFT.EarthEnvironment.EarthIonosphereResonanceEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthIonosphereResonanceGrammar.candidates do
    match EarthIonosphereResonanceEvidence.decideCandidate (EarthIonosphereResonanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthIonosphereResonanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthIonosphereResonanceEvidence.registration sourceHash),
    ("census",EarthIonosphereResonanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthIonosphereResonanceEvidence.closure decisions),
    ("controls",EarthIonosphereResonanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
