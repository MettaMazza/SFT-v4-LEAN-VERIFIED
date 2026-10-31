import SFT.Physics.UncertaintyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UncertaintyGrammar.candidates do
    match UncertaintyEvidence.decideCandidate (UncertaintyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UncertaintyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UncertaintyEvidence.registration sourceHash),
    ("census",UncertaintyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UncertaintyEvidence.closure decisions),
    ("controls",UncertaintyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
