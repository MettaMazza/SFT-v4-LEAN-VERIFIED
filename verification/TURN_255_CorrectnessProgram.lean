import SFT.Computation.CorrectnessEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CorrectnessGrammar.candidates do
    match CorrectnessEvidence.decideCandidate (CorrectnessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CorrectnessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CorrectnessEvidence.registration sourceHash),
    ("census",CorrectnessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CorrectnessEvidence.closure decisions),
    ("controls",CorrectnessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
