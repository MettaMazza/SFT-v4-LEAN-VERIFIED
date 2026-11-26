import SFT.Chemistry.OxidativeReductiveEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OxidativeReductiveGrammar.candidates do
    match OxidativeReductiveEvidence.decideCandidate (OxidativeReductiveEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OxidativeReductiveEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OxidativeReductiveEvidence.registration sourceHash),
    ("census",OxidativeReductiveEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OxidativeReductiveEvidence.closure decisions),
    ("controls",OxidativeReductiveEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
