import SFT.Computation.LocalityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LocalityGrammar.candidates do
    match LocalityEvidence.decideCandidate (LocalityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LocalityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LocalityEvidence.registration sourceHash),
    ("census",LocalityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LocalityEvidence.closure decisions),
    ("controls",LocalityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
