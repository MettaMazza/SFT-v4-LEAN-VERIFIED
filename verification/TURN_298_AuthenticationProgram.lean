import SFT.Computation.AuthenticationEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AuthenticationGrammar.candidates do
    match AuthenticationEvidence.decideCandidate (AuthenticationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AuthenticationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AuthenticationEvidence.registration sourceHash),
    ("census",AuthenticationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AuthenticationEvidence.closure decisions),
    ("controls",AuthenticationControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
