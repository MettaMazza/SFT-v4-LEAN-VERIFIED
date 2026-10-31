import SFT.Physics.ElectricDistinctionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectricDistinctionGrammar.candidates do
    match ElectricDistinctionEvidence.decideCandidate (ElectricDistinctionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectricDistinctionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectricDistinctionEvidence.registration sourceHash),
    ("census",ElectricDistinctionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectricDistinctionEvidence.closure decisions),
    ("controls",ElectricDistinctionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
