import SFT.Physics.ConservedLabelsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConservedLabelsGrammar.candidates do
    match ConservedLabelsEvidence.decideCandidate (ConservedLabelsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConservedLabelsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConservedLabelsEvidence.registration sourceHash),
    ("census",ConservedLabelsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConservedLabelsEvidence.closure decisions),
    ("controls",ConservedLabelsEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
