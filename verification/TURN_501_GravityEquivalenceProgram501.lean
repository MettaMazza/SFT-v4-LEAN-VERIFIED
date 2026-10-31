import SFT.Physics.GravityEquivalenceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityEquivalenceGrammar.candidates do
    match GravityEquivalenceEvidence.decideCandidate (GravityEquivalenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityEquivalenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityEquivalenceEvidence.registration sourceHash),
    ("census",GravityEquivalenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityEquivalenceEvidence.closure decisions),
    ("controls",GravityEquivalenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
