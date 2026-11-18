import SFT.Medicine.HealthStateEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HealthStateGrammar.candidates do
    match HealthStateEvidence.decideCandidate (HealthStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HealthStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HealthStateEvidence.registration sourceHash),
    ("census",HealthStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HealthStateEvidence.closure decisions),
    ("controls",HealthStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
