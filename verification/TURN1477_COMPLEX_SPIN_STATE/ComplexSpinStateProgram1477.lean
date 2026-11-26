import SFT.Chemistry.ComplexSpinStateEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComplexSpinStateGrammar.candidates do
    match ComplexSpinStateEvidence.decideCandidate (ComplexSpinStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComplexSpinStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComplexSpinStateEvidence.registration sourceHash),
    ("census",ComplexSpinStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComplexSpinStateEvidence.closure decisions),
    ("controls",ComplexSpinStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
