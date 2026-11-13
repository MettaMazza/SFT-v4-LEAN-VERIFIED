import SFT.Materials.SizeMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SizeMaterialGrammar.candidates do
    match SizeMaterialEvidence.decideCandidate (SizeMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SizeMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SizeMaterialEvidence.registration sourceHash),
    ("census",SizeMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SizeMaterialEvidence.closure decisions),
    ("controls",SizeMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
