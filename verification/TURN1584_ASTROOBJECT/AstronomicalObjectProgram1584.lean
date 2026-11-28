import SFT.AstronomyCosmology.AstronomicalObjectEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalObjectGrammar.candidates do
    match AstronomicalObjectEvidence.decideCandidate (AstronomicalObjectEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalObjectEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalObjectEvidence.registration sourceHash),
    ("census",AstronomicalObjectEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalObjectEvidence.closure decisions),
    ("controls",AstronomicalObjectEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
