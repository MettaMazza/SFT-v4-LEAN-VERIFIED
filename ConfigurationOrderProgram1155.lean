import SFT.Chemistry.ConfigurationOrderEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConfigurationOrderGrammar.candidates do
    match ConfigurationOrderEvidence.decideCandidate (ConfigurationOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConfigurationOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConfigurationOrderEvidence.registration sourceHash),
    ("census",ConfigurationOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConfigurationOrderEvidence.closure decisions),
    ("controls",ConfigurationOrderEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
