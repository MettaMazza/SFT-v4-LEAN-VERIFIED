import SFT.Physics.ResonanceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ResonanceGrammar.candidates do
    match ResonanceEvidence.decideCandidate (ResonanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ResonanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ResonanceEvidence.registration sourceHash),
    ("census",ResonanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ResonanceEvidence.closure decisions),
    ("controls",ResonanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
