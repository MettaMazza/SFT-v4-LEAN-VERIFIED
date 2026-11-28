import SFT.EarthEnvironment.EarthFieldObservationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthFieldObservationGrammar.candidates do
    match EarthFieldObservationEvidence.decideCandidate (EarthFieldObservationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthFieldObservationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthFieldObservationEvidence.registration sourceHash),
    ("census",EarthFieldObservationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthFieldObservationEvidence.closure decisions),
    ("controls",EarthFieldObservationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
