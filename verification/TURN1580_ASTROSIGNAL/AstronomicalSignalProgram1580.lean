import SFT.AstronomyCosmology.AstronomicalSignalEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalSignalGrammar.candidates do
    match AstronomicalSignalEvidence.decideCandidate (AstronomicalSignalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalSignalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalSignalEvidence.registration sourceHash),
    ("census",AstronomicalSignalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalSignalEvidence.closure decisions),
    ("controls",AstronomicalSignalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
