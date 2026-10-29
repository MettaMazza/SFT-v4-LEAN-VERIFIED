import SFT.Computation.RandomnessEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RandomnessGrammar.candidates do
    match RandomnessEvidence.decideCandidate (RandomnessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RandomnessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RandomnessEvidence.registration sourceHash),
    ("census",RandomnessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RandomnessEvidence.closure decisions),
    ("controls",RandomnessControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
