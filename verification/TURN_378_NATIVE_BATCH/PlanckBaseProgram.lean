import SFT.Physics.PlanckBaseEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PlanckBaseGrammar.candidates do
    match PlanckBaseEvidence.decideCandidate (PlanckBaseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PlanckBaseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PlanckBaseEvidence.registration sourceHash),
    ("census",PlanckBaseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PlanckBaseEvidence.closure decisions),
    ("controls",PlanckBaseControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
