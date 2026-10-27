import SFT.Foundation.PrimitiveMapEvidence
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PrimitiveMapGrammar.candidates do
    match PrimitiveMapEvidence.decideCandidate (PrimitiveMapEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PrimitiveMapEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PrimitiveMapEvidence.registration sourceHash),
    ("census",PrimitiveMapEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PrimitiveMapEvidence.closure decisions),
    ("controls",PrimitiveMapControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
