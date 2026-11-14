import SFT.Physics.TimelikeEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TimelikeEntryGrammar.candidates do
    match TimelikeEntryEvidence.decideCandidate (TimelikeEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TimelikeEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TimelikeEntryEvidence.registration sourceHash),
    ("census",TimelikeEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TimelikeEntryEvidence.closure decisions),
    ("controls",TimelikeEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
