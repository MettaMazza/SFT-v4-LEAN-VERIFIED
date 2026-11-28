import SFT.AstronomyCosmology.FluxLuminosityEvidence
open SFT.Host.Canonical SFT.AstronomyCosmology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FluxLuminosityGrammar.candidates do
    match FluxLuminosityEvidence.decideCandidate (FluxLuminosityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FluxLuminosityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FluxLuminosityEvidence.registration sourceHash),
    ("census",FluxLuminosityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FluxLuminosityEvidence.closure decisions),
    ("controls",FluxLuminosityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
