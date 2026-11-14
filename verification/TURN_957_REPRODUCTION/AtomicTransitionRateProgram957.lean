import SFT.Physics.AtomicTransitionRateEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicTransitionRateEntryGrammar.candidates do
    match AtomicTransitionRateEntryEvidence.decideCandidate (AtomicTransitionRateEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicTransitionRateEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicTransitionRateEntryEvidence.registration sourceHash),
    ("census",AtomicTransitionRateEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicTransitionRateEntryEvidence.closure decisions),
    ("controls",AtomicTransitionRateEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
