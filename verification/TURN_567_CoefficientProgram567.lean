import SFT.Chemistry.CoefficientEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CoefficientGrammar.candidates do
    match CoefficientEvidence.decideCandidate (CoefficientEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CoefficientEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CoefficientEvidence.registration sourceHash),
    ("census",CoefficientEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CoefficientEvidence.closure decisions),
    ("controls",CoefficientEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
