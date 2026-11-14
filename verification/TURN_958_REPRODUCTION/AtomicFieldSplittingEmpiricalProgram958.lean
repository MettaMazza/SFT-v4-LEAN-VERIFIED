import SFT.Physics.AtomicFieldSplittingEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicFieldSplittingEmpiricalGrammar.candidates do
    match AtomicFieldSplittingEmpiricalEvidence.decideCandidate (AtomicFieldSplittingEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicFieldSplittingEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicFieldSplittingEmpiricalEvidence.registration sourceHash),
    ("census",AtomicFieldSplittingEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicFieldSplittingEmpiricalEvidence.closure decisions),
    ("controls",AtomicFieldSplittingEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
