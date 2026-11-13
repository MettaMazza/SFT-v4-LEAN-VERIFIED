import SFT.Materials.SemiOpticalEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SemiOpticalGrammar.candidates do
    match SemiOpticalEvidence.decideCandidate (SemiOpticalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SemiOpticalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SemiOpticalEvidence.registration sourceHash),
    ("census",SemiOpticalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SemiOpticalEvidence.closure decisions),
    ("controls",SemiOpticalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
