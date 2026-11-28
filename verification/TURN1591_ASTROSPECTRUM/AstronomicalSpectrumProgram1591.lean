import SFT.AstronomyCosmology.AstronomicalSpectrumEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalSpectrumGrammar.candidates do
    match AstronomicalSpectrumEvidence.decideCandidate (AstronomicalSpectrumEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalSpectrumEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalSpectrumEvidence.registration sourceHash),
    ("census",AstronomicalSpectrumEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalSpectrumEvidence.closure decisions),
    ("controls",AstronomicalSpectrumEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
