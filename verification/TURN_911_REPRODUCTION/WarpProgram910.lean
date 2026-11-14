import SFT.Physics.WarpEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in WarpEntryGrammar.candidates do
    match WarpEntryEvidence.decideCandidate (WarpEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match WarpEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",WarpEntryEvidence.registration sourceHash),
    ("census",WarpEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",WarpEntryEvidence.closure decisions),
    ("controls",WarpEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
