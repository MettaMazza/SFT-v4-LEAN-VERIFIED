import SFT.Physics.ValueRecordEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ValueRecordGrammar.candidates do
    match ValueRecordEvidence.decideCandidate (ValueRecordEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ValueRecordEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ValueRecordEvidence.registration sourceHash),
    ("census",ValueRecordEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ValueRecordEvidence.closure decisions),
    ("controls",ValueRecordEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
