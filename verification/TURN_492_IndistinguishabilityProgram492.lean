import SFT.Physics.IndistinguishabilityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IndistinguishabilityGrammar.candidates do
    match IndistinguishabilityEvidence.decideCandidate (IndistinguishabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IndistinguishabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IndistinguishabilityEvidence.registration sourceHash),
    ("census",IndistinguishabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IndistinguishabilityEvidence.closure decisions),
    ("controls",IndistinguishabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
