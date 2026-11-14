import SFT.Physics.WormholeEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in WormholeEntryGrammar.candidates do
    match WormholeEntryEvidence.decideCandidate (WormholeEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match WormholeEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",WormholeEntryEvidence.registration sourceHash),
    ("census",WormholeEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",WormholeEntryEvidence.closure decisions),
    ("controls",WormholeEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
