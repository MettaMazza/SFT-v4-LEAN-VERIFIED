import SFT.Materials.PhotonicMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhotonicMaterialGrammar.candidates do
    match PhotonicMaterialEvidence.decideCandidate (PhotonicMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhotonicMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhotonicMaterialEvidence.registration sourceHash),
    ("census",PhotonicMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhotonicMaterialEvidence.closure decisions),
    ("controls",PhotonicMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
