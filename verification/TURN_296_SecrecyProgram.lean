import SFT.Computation.SecrecyEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SecrecyGrammar.candidates do
    match SecrecyEvidence.decideCandidate (SecrecyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SecrecyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SecrecyEvidence.registration sourceHash),
    ("census",SecrecyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SecrecyEvidence.closure decisions),
    ("controls",SecrecyControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
