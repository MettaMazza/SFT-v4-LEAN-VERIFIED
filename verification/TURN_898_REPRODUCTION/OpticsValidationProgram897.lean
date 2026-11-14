import SFT.Physics.OpticsValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OpticsValidationGrammar.candidates do
    match OpticsValidationEvidence.decideCandidate (OpticsValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OpticsValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OpticsValidationEvidence.registration sourceHash),
    ("census",OpticsValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OpticsValidationEvidence.closure decisions),
    ("controls",OpticsValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
