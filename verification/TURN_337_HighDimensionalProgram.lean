import SFT.Computation.HighDimensionalEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HighDimensionalGrammar.candidates do
    match HighDimensionalEvidence.decideCandidate (HighDimensionalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HighDimensionalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HighDimensionalEvidence.registration sourceHash),
    ("census",HighDimensionalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HighDimensionalEvidence.closure decisions),
    ("controls",HighDimensionalControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
