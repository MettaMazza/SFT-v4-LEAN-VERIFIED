import SFT.Materials.GlassMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GlassMaterialGrammar.candidates do
    match GlassMaterialEvidence.decideCandidate (GlassMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GlassMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GlassMaterialEvidence.registration sourceHash),
    ("census",GlassMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GlassMaterialEvidence.closure decisions),
    ("controls",GlassMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
