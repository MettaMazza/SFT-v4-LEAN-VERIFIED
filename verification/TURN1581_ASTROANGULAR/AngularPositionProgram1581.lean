import SFT.AstronomyCosmology.AngularPositionEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AngularPositionGrammar.candidates do
    match AngularPositionEvidence.decideCandidate (AngularPositionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AngularPositionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AngularPositionEvidence.registration sourceHash),
    ("census",AngularPositionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AngularPositionEvidence.closure decisions),
    ("controls",AngularPositionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
