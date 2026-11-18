import SFT.Medicine.ScreeningEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ScreeningGrammar.candidates do
    match ScreeningEvidence.decideCandidate (ScreeningEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ScreeningEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ScreeningEvidence.registration sourceHash),
    ("census",ScreeningEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ScreeningEvidence.closure decisions),
    ("controls",ScreeningEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
