import SFT.Physics.QuarkCKMValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuarkCKMValidationGrammar.candidates do
    match QuarkCKMValidationEvidence.decideCandidate (QuarkCKMValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuarkCKMValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuarkCKMValidationEvidence.registration sourceHash),
    ("census",QuarkCKMValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuarkCKMValidationEvidence.closure decisions),
    ("controls",QuarkCKMValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
