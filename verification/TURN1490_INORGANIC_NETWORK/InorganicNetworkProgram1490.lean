import SFT.Chemistry.InorganicNetworkEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InorganicNetworkGrammar.candidates do
    match InorganicNetworkEvidence.decideCandidate (InorganicNetworkEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InorganicNetworkEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InorganicNetworkEvidence.registration sourceHash),
    ("census",InorganicNetworkEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InorganicNetworkEvidence.closure decisions),
    ("controls",InorganicNetworkEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
