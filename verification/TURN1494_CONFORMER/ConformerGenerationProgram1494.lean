import SFT.Chemistry.ConformerGenerationEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConformerGenerationGrammar.candidates do
    match ConformerGenerationEvidence.decideCandidate (ConformerGenerationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConformerGenerationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConformerGenerationEvidence.registration sourceHash),
    ("census",ConformerGenerationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConformerGenerationEvidence.closure decisions),
    ("controls",ConformerGenerationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
