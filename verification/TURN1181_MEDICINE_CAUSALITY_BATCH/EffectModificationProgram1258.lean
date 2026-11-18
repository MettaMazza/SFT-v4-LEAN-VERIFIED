import SFT.Medicine.EffectModificationEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EffectModificationGrammar.candidates do
    match EffectModificationEvidence.decideCandidate (EffectModificationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EffectModificationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EffectModificationEvidence.registration sourceHash),
    ("census",EffectModificationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EffectModificationEvidence.closure decisions),
    ("controls",EffectModificationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
