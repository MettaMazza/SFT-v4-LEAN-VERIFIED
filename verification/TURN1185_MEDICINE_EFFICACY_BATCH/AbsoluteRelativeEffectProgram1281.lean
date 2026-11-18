import SFT.Medicine.AbsoluteRelativeEffectEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AbsoluteRelativeEffectGrammar.candidates do
    match AbsoluteRelativeEffectEvidence.decideCandidate (AbsoluteRelativeEffectEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AbsoluteRelativeEffectEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AbsoluteRelativeEffectEvidence.registration sourceHash),
    ("census",AbsoluteRelativeEffectEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AbsoluteRelativeEffectEvidence.closure decisions),
    ("controls",AbsoluteRelativeEffectEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
