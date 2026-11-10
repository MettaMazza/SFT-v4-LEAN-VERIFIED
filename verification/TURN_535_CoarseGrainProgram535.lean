import SFT.Physics.CoarseGrainEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CoarseGrainGrammar.candidates do
    match CoarseGrainEvidence.decideCandidate (CoarseGrainEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CoarseGrainEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CoarseGrainEvidence.registration sourceHash),
    ("census",CoarseGrainEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CoarseGrainEvidence.closure decisions),
    ("controls",CoarseGrainEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
