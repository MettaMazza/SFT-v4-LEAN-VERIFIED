import SFT.Chemistry.CovalentEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CovalentGrammar.candidates do
    match CovalentEvidence.decideCandidate (CovalentEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CovalentEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CovalentEvidence.registration sourceHash),
    ("census",CovalentEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CovalentEvidence.closure decisions),
    ("controls",CovalentEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
