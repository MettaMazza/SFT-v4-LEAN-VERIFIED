import SFT.Physics.PlasmaMHDEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PlasmaMHDGrammar.candidates do
    match PlasmaMHDEvidence.decideCandidate (PlasmaMHDEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PlasmaMHDEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PlasmaMHDEvidence.registration sourceHash),
    ("census",PlasmaMHDEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PlasmaMHDEvidence.closure decisions),
    ("controls",PlasmaMHDEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
