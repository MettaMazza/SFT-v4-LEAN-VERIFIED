import SFT.Computation.RelativeOracleEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RelativeOracleGrammar.candidates do
    match RelativeOracleEvidence.decideCandidate (RelativeOracleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RelativeOracleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RelativeOracleEvidence.registration sourceHash),
    ("census",RelativeOracleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RelativeOracleEvidence.closure decisions),
    ("controls",RelativeOracleControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
