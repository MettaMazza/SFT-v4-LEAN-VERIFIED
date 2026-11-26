import SFT.Chemistry.InorganicColourEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InorganicColourGrammar.candidates do
    match InorganicColourEvidence.decideCandidate (InorganicColourEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InorganicColourEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InorganicColourEvidence.registration sourceHash),
    ("census",InorganicColourEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InorganicColourEvidence.closure decisions),
    ("controls",InorganicColourEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
