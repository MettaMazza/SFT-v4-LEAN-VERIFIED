import SFT.Medicine.ObservationalStudyEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ObservationalStudyGrammar.candidates do
    match ObservationalStudyEvidence.decideCandidate (ObservationalStudyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ObservationalStudyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ObservationalStudyEvidence.registration sourceHash),
    ("census",ObservationalStudyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ObservationalStudyEvidence.closure decisions),
    ("controls",ObservationalStudyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
