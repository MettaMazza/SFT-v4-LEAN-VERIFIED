import SFT.Medicine.InformedConsentEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InformedConsentGrammar.candidates do
    match InformedConsentEvidence.decideCandidate (InformedConsentEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InformedConsentEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InformedConsentEvidence.registration sourceHash),
    ("census",InformedConsentEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InformedConsentEvidence.closure decisions),
    ("controls",InformedConsentEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
