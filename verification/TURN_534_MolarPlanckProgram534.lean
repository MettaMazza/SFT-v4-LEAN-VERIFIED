import SFT.Physics.MolarPlanckEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MolarPlanckGrammar.candidates do
    match MolarPlanckEvidence.decideCandidate (MolarPlanckEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MolarPlanckEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MolarPlanckEvidence.registration sourceHash),
    ("census",MolarPlanckEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MolarPlanckEvidence.closure decisions),
    ("controls",MolarPlanckEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
