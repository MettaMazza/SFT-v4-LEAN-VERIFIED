import SFT.Materials.FatigueCreepEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FatigueCreepGrammar.candidates do
    match FatigueCreepEvidence.decideCandidate (FatigueCreepEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FatigueCreepEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FatigueCreepEvidence.registration sourceHash),
    ("census",FatigueCreepEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FatigueCreepEvidence.closure decisions),
    ("controls",FatigueCreepEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
