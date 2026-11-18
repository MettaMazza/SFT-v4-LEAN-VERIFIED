import SFT.Medicine.ComparatorEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComparatorGrammar.candidates do
    match ComparatorEvidence.decideCandidate (ComparatorEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComparatorEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComparatorEvidence.registration sourceHash),
    ("census",ComparatorEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComparatorEvidence.closure decisions),
    ("controls",ComparatorEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
