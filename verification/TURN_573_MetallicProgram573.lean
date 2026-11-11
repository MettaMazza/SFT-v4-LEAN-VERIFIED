import SFT.Chemistry.MetallicEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MetallicGrammar.candidates do
    match MetallicEvidence.decideCandidate (MetallicEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MetallicEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MetallicEvidence.registration sourceHash),
    ("census",MetallicEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MetallicEvidence.closure decisions),
    ("controls",MetallicEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
