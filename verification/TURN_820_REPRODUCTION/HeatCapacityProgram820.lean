import SFT.Materials.HeatCapacityEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HeatCapacityGrammar.candidates do
    match HeatCapacityEvidence.decideCandidate (HeatCapacityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HeatCapacityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HeatCapacityEvidence.registration sourceHash),
    ("census",HeatCapacityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HeatCapacityEvidence.closure decisions),
    ("controls",HeatCapacityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
