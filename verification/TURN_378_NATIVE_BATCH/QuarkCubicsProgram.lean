import SFT.Physics.QuarkCubicsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuarkCubicsGrammar.candidates do
    match QuarkCubicsEvidence.decideCandidate (QuarkCubicsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuarkCubicsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuarkCubicsEvidence.registration sourceHash),
    ("census",QuarkCubicsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuarkCubicsEvidence.closure decisions),
    ("controls",QuarkCubicsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
