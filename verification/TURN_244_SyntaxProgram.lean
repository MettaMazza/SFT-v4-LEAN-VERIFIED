import SFT.Computation.SyntaxEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SyntaxGrammar.candidates do
    match SyntaxEvidence.decideCandidate (SyntaxEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SyntaxEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SyntaxEvidence.registration sourceHash),
    ("census",SyntaxEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SyntaxEvidence.closure decisions),
    ("controls",SyntaxControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
