import SFT.AstronomyCosmology.SurveySelectionEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SurveySelectionGrammar.candidates do
    match SurveySelectionEvidence.decideCandidate (SurveySelectionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SurveySelectionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SurveySelectionEvidence.registration sourceHash),
    ("census",SurveySelectionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SurveySelectionEvidence.closure decisions),
    ("controls",SurveySelectionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
