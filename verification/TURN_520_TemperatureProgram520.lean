import SFT.Physics.TemperatureEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TemperatureGrammar.candidates do
    match TemperatureEvidence.decideCandidate (TemperatureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TemperatureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TemperatureEvidence.registration sourceHash),
    ("census",TemperatureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TemperatureEvidence.closure decisions),
    ("controls",TemperatureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
