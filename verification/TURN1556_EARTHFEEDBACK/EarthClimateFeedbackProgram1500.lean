import SFT.EarthEnvironment.EarthClimateFeedbackEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthClimateFeedbackGrammar.candidates do
    match EarthClimateFeedbackEvidence.decideCandidate (EarthClimateFeedbackEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthClimateFeedbackEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthClimateFeedbackEvidence.registration sourceHash),
    ("census",EarthClimateFeedbackEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthClimateFeedbackEvidence.closure decisions),
    ("controls",EarthClimateFeedbackEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
