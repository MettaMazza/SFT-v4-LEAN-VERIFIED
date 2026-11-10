import SFT.Physics.IrreversibilityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IrreversibilityGrammar.candidates do
    match IrreversibilityEvidence.decideCandidate (IrreversibilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IrreversibilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IrreversibilityEvidence.registration sourceHash),
    ("census",IrreversibilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IrreversibilityEvidence.closure decisions),
    ("controls",IrreversibilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
