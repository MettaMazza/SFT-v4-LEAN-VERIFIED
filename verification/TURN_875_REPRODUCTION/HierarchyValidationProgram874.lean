import SFT.Physics.HierarchyValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HierarchyValidationGrammar.candidates do
    match HierarchyValidationEvidence.decideCandidate (HierarchyValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HierarchyValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HierarchyValidationEvidence.registration sourceHash),
    ("census",HierarchyValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HierarchyValidationEvidence.closure decisions),
    ("controls",HierarchyValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
