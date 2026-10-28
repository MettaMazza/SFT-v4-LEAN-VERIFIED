import SFT.Computation.UndecidabilityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UndecidabilityGrammar.candidates do
    match UndecidabilityEvidence.decideCandidate (UndecidabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UndecidabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UndecidabilityEvidence.registration sourceHash),
    ("census",UndecidabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UndecidabilityEvidence.closure decisions),
    ("controls",UndecidabilityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
