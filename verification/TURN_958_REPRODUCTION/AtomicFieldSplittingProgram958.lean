import SFT.Physics.AtomicFieldSplittingEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicFieldSplittingEntryGrammar.candidates do
    match AtomicFieldSplittingEntryEvidence.decideCandidate (AtomicFieldSplittingEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicFieldSplittingEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicFieldSplittingEntryEvidence.registration sourceHash),
    ("census",AtomicFieldSplittingEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicFieldSplittingEntryEvidence.closure decisions),
    ("controls",AtomicFieldSplittingEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
