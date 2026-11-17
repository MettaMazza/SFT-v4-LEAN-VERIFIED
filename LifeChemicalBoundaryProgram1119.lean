import SFT.Biology.LifeChemicalBoundaryEvidence
open SFT.Host.Canonical SFT.Biology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LifeChemicalBoundaryGrammar.candidates do
    match LifeChemicalBoundaryEvidence.decideCandidate (LifeChemicalBoundaryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LifeChemicalBoundaryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LifeChemicalBoundaryEvidence.registration sourceHash),
    ("census",LifeChemicalBoundaryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LifeChemicalBoundaryEvidence.closure decisions),
    ("controls",LifeChemicalBoundaryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
