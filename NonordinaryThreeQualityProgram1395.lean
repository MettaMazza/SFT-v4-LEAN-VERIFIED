import SFT.Consciousness.NonordinaryThreeQualityEvidence
open SFT.Host.Canonical SFT.Consciousness

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NonordinaryThreeQualityGrammar.candidates do
    match NonordinaryThreeQualityEvidence.decideCandidate (NonordinaryThreeQualityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NonordinaryThreeQualityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NonordinaryThreeQualityEvidence.registration sourceHash),
    ("census",NonordinaryThreeQualityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NonordinaryThreeQualityEvidence.closure decisions),
    ("controls",NonordinaryThreeQualityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
