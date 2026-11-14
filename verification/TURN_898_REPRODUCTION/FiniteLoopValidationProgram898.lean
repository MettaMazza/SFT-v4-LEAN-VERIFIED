import SFT.Physics.FiniteLoopValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FiniteLoopValidationGrammar.candidates do
    match FiniteLoopValidationEvidence.decideCandidate (FiniteLoopValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FiniteLoopValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FiniteLoopValidationEvidence.registration sourceHash),
    ("census",FiniteLoopValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FiniteLoopValidationEvidence.closure decisions),
    ("controls",FiniteLoopValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
