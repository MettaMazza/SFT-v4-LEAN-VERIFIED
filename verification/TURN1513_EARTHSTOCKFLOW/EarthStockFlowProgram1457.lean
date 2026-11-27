import SFT.EarthEnvironment.EarthStockFlowEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthStockFlowGrammar.candidates do
    match EarthStockFlowEvidence.decideCandidate (EarthStockFlowEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthStockFlowEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthStockFlowEvidence.registration sourceHash),
    ("census",EarthStockFlowEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthStockFlowEvidence.closure decisions),
    ("controls",EarthStockFlowEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
