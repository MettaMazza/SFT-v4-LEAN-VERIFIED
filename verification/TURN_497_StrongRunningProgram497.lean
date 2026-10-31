import SFT.Physics.StrongRunningEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StrongRunningGrammar.candidates do
    match StrongRunningEvidence.decideCandidate (StrongRunningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StrongRunningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StrongRunningEvidence.registration sourceHash),
    ("census",StrongRunningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StrongRunningEvidence.closure decisions),
    ("controls",StrongRunningControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
