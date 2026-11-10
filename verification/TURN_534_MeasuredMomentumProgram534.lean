import SFT.Physics.MeasuredMomentumEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasuredMomentumGrammar.candidates do
    match MeasuredMomentumEvidence.decideCandidate (MeasuredMomentumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasuredMomentumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasuredMomentumEvidence.registration sourceHash),
    ("census",MeasuredMomentumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasuredMomentumEvidence.closure decisions),
    ("controls",MeasuredMomentumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
