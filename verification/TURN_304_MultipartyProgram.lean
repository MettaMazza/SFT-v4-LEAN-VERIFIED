import SFT.Computation.MultipartyEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MultipartyGrammar.candidates do
    match MultipartyEvidence.decideCandidate (MultipartyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MultipartyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MultipartyEvidence.registration sourceHash),
    ("census",MultipartyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MultipartyEvidence.closure decisions),
    ("controls",MultipartyControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
