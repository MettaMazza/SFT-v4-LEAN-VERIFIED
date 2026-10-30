import SFT.Computation.ReinforcementEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ReinforcementGrammar.candidates do
    match ReinforcementEvidence.decideCandidate (ReinforcementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ReinforcementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ReinforcementEvidence.registration sourceHash),
    ("census",ReinforcementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ReinforcementEvidence.closure decisions),
    ("controls",ReinforcementControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
