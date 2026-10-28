import SFT.Mathematics.ProbabilityEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ProbabilityGrammar.candidates do
    match ProbabilityEvidence.decideCandidate (ProbabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ProbabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ProbabilityEvidence.registration sourceHash),
    ("census",ProbabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ProbabilityEvidence.closure decisions),
    ("controls",ProbabilityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
