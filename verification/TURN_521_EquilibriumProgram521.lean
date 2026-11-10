import SFT.Physics.EquilibriumEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EquilibriumGrammar.candidates do
    match EquilibriumEvidence.decideCandidate (EquilibriumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EquilibriumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EquilibriumEvidence.registration sourceHash),
    ("census",EquilibriumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EquilibriumEvidence.closure decisions),
    ("controls",EquilibriumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
