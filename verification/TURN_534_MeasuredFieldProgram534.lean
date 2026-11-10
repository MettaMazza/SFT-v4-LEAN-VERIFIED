import SFT.Physics.MeasuredFieldEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasuredFieldGrammar.candidates do
    match MeasuredFieldEvidence.decideCandidate (MeasuredFieldEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasuredFieldEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasuredFieldEvidence.registration sourceHash),
    ("census",MeasuredFieldEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasuredFieldEvidence.closure decisions),
    ("controls",MeasuredFieldEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
