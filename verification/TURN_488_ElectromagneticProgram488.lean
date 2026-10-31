import SFT.Physics.ElectromagneticEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectromagneticGrammar.candidates do
    match ElectromagneticEvidence.decideCandidate (ElectromagneticEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectromagneticEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectromagneticEvidence.registration sourceHash),
    ("census",ElectromagneticEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectromagneticEvidence.closure decisions),
    ("controls",ElectromagneticEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
