import SFT.EarthEnvironment.EarthWaterPhaseHandoffEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthWaterPhaseHandoffGrammar.candidates do
    match EarthWaterPhaseHandoffEvidence.decideCandidate (EarthWaterPhaseHandoffEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthWaterPhaseHandoffEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthWaterPhaseHandoffEvidence.registration sourceHash),
    ("census",EarthWaterPhaseHandoffEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthWaterPhaseHandoffEvidence.closure decisions),
    ("controls",EarthWaterPhaseHandoffEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
