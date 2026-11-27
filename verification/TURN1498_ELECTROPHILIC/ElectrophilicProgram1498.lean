import SFT.Chemistry.ElectrophilicEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectrophilicGrammar.candidates do
    match ElectrophilicEvidence.decideCandidate (ElectrophilicEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectrophilicEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectrophilicEvidence.registration sourceHash),
    ("census",ElectrophilicEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectrophilicEvidence.closure decisions),
    ("controls",ElectrophilicEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
