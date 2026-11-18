import SFT.Medicine.ComorbidityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ComorbidityGrammar.candidates do
    match ComorbidityEvidence.decideCandidate (ComorbidityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ComorbidityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ComorbidityEvidence.registration sourceHash),
    ("census",ComorbidityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ComorbidityEvidence.closure decisions),
    ("controls",ComorbidityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
