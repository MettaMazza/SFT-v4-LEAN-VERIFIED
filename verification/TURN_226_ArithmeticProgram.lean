import SFT.Computation.ArithmeticEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ArithmeticGrammar.candidates do
    match ArithmeticEvidence.decideCandidate (ArithmeticEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ArithmeticEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ArithmeticEvidence.registration sourceHash),
    ("census",ArithmeticEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ArithmeticEvidence.closure decisions),
    ("controls",ArithmeticControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
