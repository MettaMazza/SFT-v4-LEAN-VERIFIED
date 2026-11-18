import SFT.Medicine.RehabilitationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RehabilitationGrammar.candidates do
    match RehabilitationEvidence.decideCandidate (RehabilitationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RehabilitationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RehabilitationEvidence.registration sourceHash),
    ("census",RehabilitationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RehabilitationEvidence.closure decisions),
    ("controls",RehabilitationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
