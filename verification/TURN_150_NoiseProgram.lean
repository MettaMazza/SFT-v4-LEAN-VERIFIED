import SFT.InformationScience.NoiseEvidence
open SFT.Host.Canonical SFT.InformationScience

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NoiseGrammar.candidates do
    match NoiseEvidence.decideCandidate (NoiseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NoiseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NoiseEvidence.registration sourceHash),
    ("census",NoiseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NoiseEvidence.closure decisions),
    ("controls",NoiseControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
