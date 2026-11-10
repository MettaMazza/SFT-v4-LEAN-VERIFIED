import SFT.Physics.FluctuationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FluctuationGrammar.candidates do
    match FluctuationEvidence.decideCandidate (FluctuationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FluctuationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FluctuationEvidence.registration sourceHash),
    ("census",FluctuationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FluctuationEvidence.closure decisions),
    ("controls",FluctuationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
