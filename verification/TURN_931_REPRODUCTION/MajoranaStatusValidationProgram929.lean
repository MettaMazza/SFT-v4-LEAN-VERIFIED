import SFT.Physics.MajoranaStatusValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MajoranaStatusValidationGrammar.candidates do
    match MajoranaStatusValidationEvidence.decideCandidate (MajoranaStatusValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MajoranaStatusValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MajoranaStatusValidationEvidence.registration sourceHash),
    ("census",MajoranaStatusValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MajoranaStatusValidationEvidence.closure decisions),
    ("controls",MajoranaStatusValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
