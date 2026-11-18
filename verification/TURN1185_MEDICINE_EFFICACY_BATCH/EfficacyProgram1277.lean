import SFT.Medicine.EfficacyEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EfficacyGrammar.candidates do
    match EfficacyEvidence.decideCandidate (EfficacyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EfficacyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EfficacyEvidence.registration sourceHash),
    ("census",EfficacyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EfficacyEvidence.closure decisions),
    ("controls",EfficacyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
