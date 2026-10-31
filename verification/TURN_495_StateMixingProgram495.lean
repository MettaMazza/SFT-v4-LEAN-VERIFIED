import SFT.Physics.StateMixingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StateMixingGrammar.candidates do
    match StateMixingEvidence.decideCandidate (StateMixingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StateMixingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StateMixingEvidence.registration sourceHash),
    ("census",StateMixingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StateMixingEvidence.closure decisions),
    ("controls",StateMixingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
