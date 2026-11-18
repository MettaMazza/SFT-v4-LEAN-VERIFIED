import SFT.Medicine.CointerventionEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CointerventionGrammar.candidates do
    match CointerventionEvidence.decideCandidate (CointerventionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CointerventionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CointerventionEvidence.registration sourceHash),
    ("census",CointerventionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CointerventionEvidence.closure decisions),
    ("controls",CointerventionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
