import SFT.Chemistry.SolutionEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SolutionGrammar.candidates do
    match SolutionEvidence.decideCandidate (SolutionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SolutionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SolutionEvidence.registration sourceHash),
    ("census",SolutionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SolutionEvidence.closure decisions),
    ("controls",SolutionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
