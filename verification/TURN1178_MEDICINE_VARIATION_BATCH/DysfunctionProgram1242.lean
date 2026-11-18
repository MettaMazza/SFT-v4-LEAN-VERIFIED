import SFT.Medicine.DysfunctionEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DysfunctionGrammar.candidates do
    match DysfunctionEvidence.decideCandidate (DysfunctionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DysfunctionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DysfunctionEvidence.registration sourceHash),
    ("census",DysfunctionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DysfunctionEvidence.closure decisions),
    ("controls",DysfunctionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
