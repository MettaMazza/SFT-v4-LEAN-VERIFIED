import SFT.Computation.ComputationalStatisticsEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComputationalStatisticsGrammar.candidates do
    match ComputationalStatisticsEvidence.decideCandidate (ComputationalStatisticsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComputationalStatisticsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComputationalStatisticsEvidence.registration sourceHash),
    ("census",ComputationalStatisticsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComputationalStatisticsEvidence.closure decisions),
    ("controls",ComputationalStatisticsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
