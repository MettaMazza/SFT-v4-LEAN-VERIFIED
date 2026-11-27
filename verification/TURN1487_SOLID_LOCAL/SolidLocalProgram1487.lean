import SFT.Chemistry.SolidLocalEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SolidLocalGrammar.candidates do
    match SolidLocalEvidence.decideCandidate (SolidLocalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SolidLocalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SolidLocalEvidence.registration sourceHash),
    ("census",SolidLocalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SolidLocalEvidence.closure decisions),
    ("controls",SolidLocalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
