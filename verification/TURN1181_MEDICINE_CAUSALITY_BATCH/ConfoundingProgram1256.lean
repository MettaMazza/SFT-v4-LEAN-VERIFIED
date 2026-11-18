import SFT.Medicine.ConfoundingEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConfoundingGrammar.candidates do
    match ConfoundingEvidence.decideCandidate (ConfoundingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConfoundingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConfoundingEvidence.registration sourceHash),
    ("census",ConfoundingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConfoundingEvidence.closure decisions),
    ("controls",ConfoundingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
