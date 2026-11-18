import SFT.Medicine.LongitudinalCourseEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LongitudinalCourseGrammar.candidates do
    match LongitudinalCourseEvidence.decideCandidate (LongitudinalCourseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LongitudinalCourseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LongitudinalCourseEvidence.registration sourceHash),
    ("census",LongitudinalCourseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LongitudinalCourseEvidence.closure decisions),
    ("controls",LongitudinalCourseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
