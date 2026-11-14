import SFT.Physics.AtomicTransitionRateEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicTransitionRateEmpiricalGrammar.candidates do
    match AtomicTransitionRateEmpiricalEvidence.decideCandidate (AtomicTransitionRateEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicTransitionRateEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicTransitionRateEmpiricalEvidence.registration sourceHash),
    ("census",AtomicTransitionRateEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicTransitionRateEmpiricalEvidence.closure decisions),
    ("controls",AtomicTransitionRateEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
