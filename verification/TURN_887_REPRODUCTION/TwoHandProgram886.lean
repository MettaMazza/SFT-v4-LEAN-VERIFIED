import SFT.Physics.TwoHandEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TwoHandGrammar.candidates do
    match TwoHandEvidence.decideCandidate (TwoHandEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TwoHandEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TwoHandEvidence.registration sourceHash),
    ("census",TwoHandEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TwoHandEvidence.closure decisions),
    ("controls",TwoHandControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
