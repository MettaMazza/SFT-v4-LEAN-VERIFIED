import SFT.Physics.PhaseEquilibriumEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhaseEquilibriumGrammar.candidates do
    match PhaseEquilibriumEvidence.decideCandidate (PhaseEquilibriumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhaseEquilibriumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhaseEquilibriumEvidence.registration sourceHash),
    ("census",PhaseEquilibriumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhaseEquilibriumEvidence.closure decisions),
    ("controls",PhaseEquilibriumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
