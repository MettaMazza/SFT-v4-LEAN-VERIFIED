import SFT.Physics.ElectricPotentialEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectricPotentialGrammar.candidates do
    match ElectricPotentialEvidence.decideCandidate (ElectricPotentialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectricPotentialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectricPotentialEvidence.registration sourceHash),
    ("census",ElectricPotentialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectricPotentialEvidence.closure decisions),
    ("controls",ElectricPotentialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
