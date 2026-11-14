import SFT.Physics.AtomicShellPeriodicityEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicShellPeriodicityEntryGrammar.candidates do
    match AtomicShellPeriodicityEntryEvidence.decideCandidate (AtomicShellPeriodicityEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicShellPeriodicityEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicShellPeriodicityEntryEvidence.registration sourceHash),
    ("census",AtomicShellPeriodicityEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicShellPeriodicityEntryEvidence.closure decisions),
    ("controls",AtomicShellPeriodicityEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
