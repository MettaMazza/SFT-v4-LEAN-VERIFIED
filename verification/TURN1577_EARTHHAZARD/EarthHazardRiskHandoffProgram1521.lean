import SFT.EarthEnvironment.EarthHazardRiskHandoffEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthHazardRiskHandoffGrammar.candidates do
    match EarthHazardRiskHandoffEvidence.decideCandidate (EarthHazardRiskHandoffEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthHazardRiskHandoffEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthHazardRiskHandoffEvidence.registration sourceHash),
    ("census",EarthHazardRiskHandoffEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthHazardRiskHandoffEvidence.closure decisions),
    ("controls",EarthHazardRiskHandoffEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
