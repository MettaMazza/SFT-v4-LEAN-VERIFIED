import SFT.Chemistry.IsotopeEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IsotopeGrammar.candidates do
    match IsotopeEvidence.decideCandidate (IsotopeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IsotopeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IsotopeEvidence.registration sourceHash),
    ("census",IsotopeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IsotopeEvidence.closure decisions),
    ("controls",IsotopeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
