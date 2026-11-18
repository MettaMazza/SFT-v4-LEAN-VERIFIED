import SFT.Chemistry.AnalyticalPrecisionEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AnalyticalPrecisionGrammar.candidates do
    match AnalyticalPrecisionEvidence.decideCandidate (AnalyticalPrecisionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AnalyticalPrecisionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AnalyticalPrecisionEvidence.registration sourceHash),
    ("census",AnalyticalPrecisionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AnalyticalPrecisionEvidence.closure decisions),
    ("controls",AnalyticalPrecisionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
