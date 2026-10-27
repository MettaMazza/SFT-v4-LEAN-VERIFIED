import SFT
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FormEnforcementGrammar.candidates do
    match FormEnforcementEvidence.decideCandidate (FormEnforcementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FormEnforcementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FormEnforcementEvidence.registration sourceHash),
    ("census",FormEnforcementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FormEnforcementEvidence.closure decisions),
    ("controls",FormEnforcementControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
