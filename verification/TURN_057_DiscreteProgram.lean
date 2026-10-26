import SFT
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DiscreteGrammar.candidates do
    match DiscreteEvidence.decideCandidate (DiscreteEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DiscreteEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DiscreteEvidence.registration sourceHash),
    ("census",DiscreteEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DiscreteEvidence.closure decisions),
    ("controls",DiscreteControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
