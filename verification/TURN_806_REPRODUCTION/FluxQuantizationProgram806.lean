import SFT.Materials.FluxQuantizationEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FluxQuantizationGrammar.candidates do
    match FluxQuantizationEvidence.decideCandidate (FluxQuantizationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FluxQuantizationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FluxQuantizationEvidence.registration sourceHash),
    ("census",FluxQuantizationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FluxQuantizationEvidence.closure decisions),
    ("controls",FluxQuantizationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
