import SFT.Materials.PorousMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PorousMaterialGrammar.candidates do
    match PorousMaterialEvidence.decideCandidate (PorousMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PorousMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PorousMaterialEvidence.registration sourceHash),
    ("census",PorousMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PorousMaterialEvidence.closure decisions),
    ("controls",PorousMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
