import SFT.Physics.IncompatibilityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IncompatibilityGrammar.candidates do
    match IncompatibilityEvidence.decideCandidate (IncompatibilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IncompatibilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IncompatibilityEvidence.registration sourceHash),
    ("census",IncompatibilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IncompatibilityEvidence.closure decisions),
    ("controls",IncompatibilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
