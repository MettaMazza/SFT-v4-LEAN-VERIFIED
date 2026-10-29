import SFT.Computation.SemBindingEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SemBindingGrammar.candidates do
    match SemBindingEvidence.decideCandidate (SemBindingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SemBindingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SemBindingEvidence.registration sourceHash),
    ("census",SemBindingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SemBindingEvidence.closure decisions),
    ("controls",SemBindingControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
