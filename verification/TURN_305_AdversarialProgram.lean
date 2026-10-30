import SFT.Computation.AdversarialEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AdversarialGrammar.candidates do
    match AdversarialEvidence.decideCandidate (AdversarialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AdversarialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AdversarialEvidence.registration sourceHash),
    ("census",AdversarialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AdversarialEvidence.closure decisions),
    ("controls",AdversarialControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
