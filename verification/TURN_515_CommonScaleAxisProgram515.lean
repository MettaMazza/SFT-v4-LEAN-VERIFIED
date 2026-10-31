import SFT.Physics.CommonScaleAxisEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisionBuffer : Array SFT.Engine.CandidateDecision := #[]
  for c in CommonScaleAxisGrammar.candidates do
    match CommonScaleAxisEvidence.decideCandidate (CommonScaleAxisEvidence.generatedCandidateData c) with
    | .ok decision => decisionBuffer := decisionBuffer.push decision
    | .error e => throw (IO.userError e)
  let decisions := decisionBuffer.toList
  let unknown := match CommonScaleAxisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CommonScaleAxisEvidence.registration sourceHash),
    ("census",CommonScaleAxisEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CommonScaleAxisEvidence.closure decisions),
    ("controls",CommonScaleAxisControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
