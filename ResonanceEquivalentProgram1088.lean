import SFT.Chemistry.ResonanceEquivalentEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ResonanceEquivalentGrammar.candidates do
    match ResonanceEquivalentEvidence.decideCandidate (ResonanceEquivalentEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ResonanceEquivalentEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ResonanceEquivalentEvidence.registration sourceHash),
    ("census",ResonanceEquivalentEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ResonanceEquivalentEvidence.closure decisions),
    ("controls",ResonanceEquivalentEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
