import SFT.Physics.QuarkChannelsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuarkChannelsGrammar.candidates do
    match QuarkChannelsEvidence.decideCandidate (QuarkChannelsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuarkChannelsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuarkChannelsEvidence.registration sourceHash),
    ("census",QuarkChannelsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuarkChannelsEvidence.closure decisions),
    ("controls",QuarkChannelsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
