import SFT.Medicine.DoseResponseEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DoseResponseGrammar.candidates do
    match DoseResponseEvidence.decideCandidate (DoseResponseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DoseResponseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DoseResponseEvidence.registration sourceHash),
    ("census",DoseResponseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DoseResponseEvidence.closure decisions),
    ("controls",DoseResponseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
