import SFT.Chemistry.AtomicWeightEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicWeightGrammar.candidates do
    match AtomicWeightEvidence.decideCandidate (AtomicWeightEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicWeightEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicWeightEvidence.registration sourceHash),
    ("census",AtomicWeightEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicWeightEvidence.closure decisions),
    ("controls",AtomicWeightEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
