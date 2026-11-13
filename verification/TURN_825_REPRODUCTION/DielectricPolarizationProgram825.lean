import SFT.Materials.DielectricPolarizationEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DielectricPolarizationGrammar.candidates do
    match DielectricPolarizationEvidence.decideCandidate (DielectricPolarizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DielectricPolarizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DielectricPolarizationEvidence.registration sourceHash),
    ("census",DielectricPolarizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DielectricPolarizationEvidence.closure decisions),
    ("controls",DielectricPolarizationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
