import SFT.Physics.InflationObservationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InflationObservationGrammar.candidates do
    match InflationObservationEvidence.decideCandidate (InflationObservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InflationObservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InflationObservationEvidence.registration sourceHash),
    ("census",InflationObservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InflationObservationEvidence.closure decisions),
    ("controls",InflationObservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
