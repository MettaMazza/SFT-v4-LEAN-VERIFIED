import SFT.Materials.UnitCellEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UnitCellGrammar.candidates do
    match UnitCellEvidence.decideCandidate (UnitCellEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UnitCellEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UnitCellEvidence.registration sourceHash),
    ("census",UnitCellEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UnitCellEvidence.closure decisions),
    ("controls",UnitCellEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
