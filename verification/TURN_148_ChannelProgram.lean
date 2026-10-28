import SFT.InformationScience.ChannelEvidence
open SFT.Host.Canonical SFT.InformationScience

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ChannelGrammar.candidates do
    match ChannelEvidence.decideCandidate (ChannelEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ChannelEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ChannelEvidence.registration sourceHash),
    ("census",ChannelEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ChannelEvidence.closure decisions),
    ("controls",ChannelControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
