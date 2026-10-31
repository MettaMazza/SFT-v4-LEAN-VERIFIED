import SFT.Physics.CosmoLensingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CosmoLensingGrammar.candidates do
    match CosmoLensingEvidence.decideCandidate (CosmoLensingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CosmoLensingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmoLensingEvidence.registration sourceHash),
    ("census",CosmoLensingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmoLensingEvidence.closure decisions),
    ("controls",CosmoLensingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
