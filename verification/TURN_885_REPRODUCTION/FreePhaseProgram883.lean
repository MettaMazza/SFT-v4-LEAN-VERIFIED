import SFT.Physics.FreePhaseEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FreePhaseGrammar.candidates do
    match FreePhaseEvidence.decideCandidate (FreePhaseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FreePhaseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FreePhaseEvidence.registration sourceHash),
    ("census",FreePhaseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FreePhaseEvidence.closure decisions),
    ("controls",FreePhaseControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
