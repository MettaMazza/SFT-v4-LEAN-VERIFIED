import SFT.Chemistry.AtomicNumberEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AtomicNumberGrammar.candidates do
    match AtomicNumberEvidence.decideCandidate (AtomicNumberEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AtomicNumberEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AtomicNumberEvidence.registration sourceHash),
    ("census",AtomicNumberEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AtomicNumberEvidence.closure decisions),
    ("controls",AtomicNumberEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
