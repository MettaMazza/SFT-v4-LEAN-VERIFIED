import SFT.Computation.SearchPlanningEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SearchPlanningGrammar.candidates do
    match SearchPlanningEvidence.decideCandidate (SearchPlanningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SearchPlanningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SearchPlanningEvidence.registration sourceHash),
    ("census",SearchPlanningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SearchPlanningEvidence.closure decisions),
    ("controls",SearchPlanningControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
