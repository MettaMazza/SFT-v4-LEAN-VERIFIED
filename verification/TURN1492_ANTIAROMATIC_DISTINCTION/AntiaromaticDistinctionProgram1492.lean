import SFT.Chemistry.AntiaromaticDistinctionEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AntiaromaticDistinctionGrammar.candidates do
    match AntiaromaticDistinctionEvidence.decideCandidate (AntiaromaticDistinctionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AntiaromaticDistinctionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AntiaromaticDistinctionEvidence.registration sourceHash),
    ("census",AntiaromaticDistinctionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AntiaromaticDistinctionEvidence.closure decisions),
    ("controls",AntiaromaticDistinctionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
