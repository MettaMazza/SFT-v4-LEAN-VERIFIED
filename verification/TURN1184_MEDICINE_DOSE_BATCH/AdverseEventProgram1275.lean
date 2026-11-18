import SFT.Medicine.AdverseEventEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AdverseEventGrammar.candidates do
    match AdverseEventEvidence.decideCandidate (AdverseEventEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AdverseEventEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AdverseEventEvidence.registration sourceHash),
    ("census",AdverseEventEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AdverseEventEvidence.closure decisions),
    ("controls",AdverseEventEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
