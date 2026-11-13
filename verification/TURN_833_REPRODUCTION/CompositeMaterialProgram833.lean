import SFT.Materials.CompositeMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CompositeMaterialGrammar.candidates do
    match CompositeMaterialEvidence.decideCandidate (CompositeMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CompositeMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CompositeMaterialEvidence.registration sourceHash),
    ("census",CompositeMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CompositeMaterialEvidence.closure decisions),
    ("controls",CompositeMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
