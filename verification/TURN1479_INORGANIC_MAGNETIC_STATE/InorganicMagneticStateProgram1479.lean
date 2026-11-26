import SFT.Chemistry.InorganicMagneticStateEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InorganicMagneticStateGrammar.candidates do
    match InorganicMagneticStateEvidence.decideCandidate (InorganicMagneticStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InorganicMagneticStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InorganicMagneticStateEvidence.registration sourceHash),
    ("census",InorganicMagneticStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InorganicMagneticStateEvidence.closure decisions),
    ("controls",InorganicMagneticStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
