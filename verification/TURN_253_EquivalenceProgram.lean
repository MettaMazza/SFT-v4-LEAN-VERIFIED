import SFT.Computation.EquivalenceEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EquivalenceGrammar.candidates do
    match EquivalenceEvidence.decideCandidate (EquivalenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EquivalenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EquivalenceEvidence.registration sourceHash),
    ("census",EquivalenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EquivalenceEvidence.closure decisions),
    ("controls",EquivalenceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
