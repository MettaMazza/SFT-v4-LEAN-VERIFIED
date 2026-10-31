import SFT.Physics.ColourCouplingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ColourCouplingGrammar.candidates do
    match ColourCouplingEvidence.decideCandidate (ColourCouplingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ColourCouplingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ColourCouplingEvidence.registration sourceHash),
    ("census",ColourCouplingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ColourCouplingEvidence.closure decisions),
    ("controls",ColourCouplingControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
