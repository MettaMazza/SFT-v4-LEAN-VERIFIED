import SFT.Computation.SecurityDefinitionEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SecurityDefinitionGrammar.candidates do
    match SecurityDefinitionEvidence.decideCandidate (SecurityDefinitionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SecurityDefinitionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SecurityDefinitionEvidence.registration sourceHash),
    ("census",SecurityDefinitionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SecurityDefinitionEvidence.closure decisions),
    ("controls",SecurityDefinitionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
