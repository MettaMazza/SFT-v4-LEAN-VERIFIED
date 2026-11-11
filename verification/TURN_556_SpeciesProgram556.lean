import SFT.Chemistry.SpeciesEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SpeciesGrammar.candidates do
    match SpeciesEvidence.decideCandidate (SpeciesEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SpeciesEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SpeciesEvidence.registration sourceHash),
    ("census",SpeciesEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SpeciesEvidence.closure decisions),
    ("controls",SpeciesEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
