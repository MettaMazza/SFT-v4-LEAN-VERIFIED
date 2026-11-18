import SFT.Medicine.EvidenceSynthesisEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EvidenceSynthesisGrammar.candidates do
    match EvidenceSynthesisEvidence.decideCandidate (EvidenceSynthesisEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EvidenceSynthesisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EvidenceSynthesisEvidence.registration sourceHash),
    ("census",EvidenceSynthesisEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EvidenceSynthesisEvidence.closure decisions),
    ("controls",EvidenceSynthesisEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
