import SFT.AstronomyCosmology.AstronomicalRedshiftEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AstronomicalRedshiftGrammar.candidates do
    match AstronomicalRedshiftEvidence.decideCandidate (AstronomicalRedshiftEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AstronomicalRedshiftEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AstronomicalRedshiftEvidence.registration sourceHash),
    ("census",AstronomicalRedshiftEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AstronomicalRedshiftEvidence.closure decisions),
    ("controls",AstronomicalRedshiftEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
