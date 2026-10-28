import SFT.Computation.InputSizeEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InputSizeGrammar.candidates do
    match InputSizeEvidence.decideCandidate (InputSizeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InputSizeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InputSizeEvidence.registration sourceHash),
    ("census",InputSizeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InputSizeEvidence.closure decisions),
    ("controls",InputSizeControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
