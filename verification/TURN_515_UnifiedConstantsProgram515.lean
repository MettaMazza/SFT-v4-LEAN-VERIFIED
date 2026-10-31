import SFT.Physics.UnifiedConstantsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisionBuffer : Array SFT.Engine.CandidateDecision := #[]
  for c in UnifiedConstantsGrammar.candidates do
    match UnifiedConstantsEvidence.decideCandidate (UnifiedConstantsEvidence.generatedCandidateData c) with
    | .ok decision => decisionBuffer := decisionBuffer.push decision
    | .error e => throw (IO.userError e)
  let decisions := decisionBuffer.toList
  let unknown := match UnifiedConstantsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UnifiedConstantsEvidence.registration sourceHash),
    ("census",UnifiedConstantsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UnifiedConstantsEvidence.closure decisions),
    ("controls",UnifiedConstantsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
