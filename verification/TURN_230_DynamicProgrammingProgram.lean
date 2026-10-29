import SFT.Computation.DynamicProgrammingEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DynamicProgrammingGrammar.candidates do
    match DynamicProgrammingEvidence.decideCandidate (DynamicProgrammingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DynamicProgrammingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DynamicProgrammingEvidence.registration sourceHash),
    ("census",DynamicProgrammingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DynamicProgrammingEvidence.closure decisions),
    ("controls",DynamicProgrammingControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
