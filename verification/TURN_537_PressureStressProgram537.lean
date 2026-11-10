import SFT.Physics.PressureStressEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PressureStressGrammar.candidates do
    match PressureStressEvidence.decideCandidate (PressureStressEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PressureStressEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PressureStressEvidence.registration sourceHash),
    ("census",PressureStressEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PressureStressEvidence.closure decisions),
    ("controls",PressureStressEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
