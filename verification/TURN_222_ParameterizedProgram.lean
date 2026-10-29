import SFT.Computation.ParameterizedEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ParameterizedGrammar.candidates do
    match ParameterizedEvidence.decideCandidate (ParameterizedEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ParameterizedEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ParameterizedEvidence.registration sourceHash),
    ("census",ParameterizedEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ParameterizedEvidence.closure decisions),
    ("controls",ParameterizedControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
